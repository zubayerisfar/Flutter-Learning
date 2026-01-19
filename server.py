from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from pydantic import BaseModel, EmailStr
from typing import Optional, List
from sqlalchemy import create_engine, Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session, relationship
import hashlib
import secrets
from datetime import datetime, timedelta
import uvicorn

# Database setup
DATABASE_URL = "sqlite:///./app.db"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# SQLAlchemy Models


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, nullable=False, index=True)
    username = Column(String, unique=True, nullable=False, index=True)
    password_hash = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.now)

    tokens = relationship("Token", back_populates="user",
                          cascade="all, delete-orphan")
    items = relationship("Item", back_populates="owner",
                         cascade="all, delete-orphan")


class Token(Base):
    __tablename__ = "tokens"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    token = Column(String, unique=True, nullable=False, index=True)
    expires_at = Column(DateTime, nullable=False)

    user = relationship("User", back_populates="tokens")


class Item(Base):
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(String, nullable=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    created_at = Column(DateTime, default=datetime.now)
    updated_at = Column(DateTime, default=datetime.now, onupdate=datetime.now)

    owner = relationship("User", back_populates="items")


# Create tables
Base.metadata.create_all(bind=engine)

app = FastAPI(title="Flutter Backend API")
security = HTTPBearer()

# Database dependency


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Pydantic models


class UserRegister(BaseModel):
    email: EmailStr
    username: str
    password: str


class UserLogin(BaseModel):
    username: str
    password: str


class UserResponse(BaseModel):
    id: int
    email: str
    username: str
    created_at: str


class TokenResponse(BaseModel):
    token: str
    user: UserResponse


class ItemCreate(BaseModel):
    title: str
    description: Optional[str] = None


class ItemUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None


class ItemResponse(BaseModel):
    id: int
    title: str
    description: Optional[str]
    user_id: int
    created_at: str
    updated_at: str

# Helper functions


def hash_password(password: str) -> str:
    return hashlib.sha256(password.encode()).hexdigest()


def generate_token() -> str:
    return secrets.token_urlsafe(32)


def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security), db: Session = Depends(get_db)):
    token_str = credentials.credentials

    token = db.query(Token).filter(
        Token.token == token_str,
        Token.expires_at > datetime.now()
    ).first()

    if not token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired token"
        )

    user = db.query(User).filter(User.id == token.user_id).first()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not found"
        )

    return user

# Auth endpoints


@app.post("/api/register", response_model=TokenResponse, status_code=status.HTTP_201_CREATED)
async def register(user_data: UserRegister, db: Session = Depends(get_db)):
    # Check if user exists
    existing_user = db.query(User).filter(
        (User.email == user_data.email) | (User.username == user_data.username)
    ).first()

    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email or username already exists"
        )

    # Create new user
    password_hash = hash_password(user_data.password)
    new_user = User(
        email=user_data.email,
        username=user_data.username,
        password_hash=password_hash
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Generate token
    token_str = generate_token()
    expires_at = datetime.now() + timedelta(days=30)
    new_token = Token(
        user_id=new_user.id,
        token=token_str,
        expires_at=expires_at
    )
    db.add(new_token)
    db.commit()

    return {
        "token": token_str,
        "user": {
            "id": new_user.id,
            "email": new_user.email,
            "username": new_user.username,
            "created_at": str(new_user.created_at)
        }
    }


@app.post("/api/login", response_model=TokenResponse)
async def login(user_data: UserLogin, db: Session = Depends(get_db)):
    password_hash = hash_password(user_data.password)

    user = db.query(User).filter(
        User.username == user_data.username,
        User.password_hash == password_hash
    ).first()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid username or password"
        )

    # Generate new token
    token_str = generate_token()
    expires_at = datetime.now() + timedelta(days=30)
    new_token = Token(
        user_id=user.id,
        token=token_str,
        expires_at=expires_at
    )
    db.add(new_token)
    db.commit()

    return {
        "token": token_str,
        "user": {
            "id": user.id,
            "email": user.email,
            "username": user.username,
            "created_at": str(user.created_at)
        }
    }


@app.post("/api/logout")
async def logout(credentials: HTTPAuthorizationCredentials = Depends(security), current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    token_str = credentials.credentials
    db.query(Token).filter(Token.token == token_str).delete()
    db.commit()
    return {"message": "Logged out successfully"}


@app.get("/api/me", response_model=UserResponse)
async def get_me(current_user: User = Depends(get_current_user)):
    return {
        "id": current_user.id,
        "email": current_user.email,
        "username": current_user.username,
        "created_at": str(current_user.created_at)
    }

# CRUD endpoints for items


@app.post("/api/items", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
async def create_item(item_data: ItemCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    new_item = Item(
        title=item_data.title,
        description=item_data.description,
        user_id=current_user.id
    )
    db.add(new_item)
    db.commit()
    db.refresh(new_item)

    return {
        "id": new_item.id,
        "title": new_item.title,
        "description": new_item.description,
        "user_id": new_item.user_id,
        "created_at": str(new_item.created_at),
        "updated_at": str(new_item.updated_at)
    }


@app.get("/api/items", response_model=List[ItemResponse])
async def get_items(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    items = db.query(Item).filter(Item.user_id == current_user.id).order_by(
        Item.created_at.desc()).all()

    return [{
        "id": item.id,
        "title": item.title,
        "description": item.description,
        "user_id": item.user_id,
        "created_at": str(item.created_at),
        "updated_at": str(item.updated_at)
    } for item in items]


@app.get("/api/items/{item_id}", response_model=ItemResponse)
async def get_item(item_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    item = db.query(Item).filter(Item.id == item_id,
                                 Item.user_id == current_user.id).first()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found"
        )

    return {
        "id": item.id,
        "title": item.title,
        "description": item.description,
        "user_id": item.user_id,
        "created_at": str(item.created_at),
        "updated_at": str(item.updated_at)
    }


@app.put("/api/items/{item_id}", response_model=ItemResponse)
async def update_item(item_id: int, item_data: ItemUpdate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    item = db.query(Item).filter(Item.id == item_id,
                                 Item.user_id == current_user.id).first()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found"
        )

    update_data = item_data.model_dump(exclude_unset=True)

    if update_data:
        for key, value in update_data.items():
            setattr(item, key, value)
        item.updated_at = datetime.now()
        db.commit()
        db.refresh(item)

    return {
        "id": item.id,
        "title": item.title,
        "description": item.description,
        "user_id": item.user_id,
        "created_at": str(item.created_at),
        "updated_at": str(item.updated_at)
    }


@app.delete("/api/items/{item_id}")
async def delete_item(item_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    item = db.query(Item).filter(Item.id == item_id,
                                 Item.user_id == current_user.id).first()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found"
        )

    db.delete(item)
    db.commit()

    return {"message": "Item deleted successfully"}

# Root endpoint


@app.get("/")
async def root():
    return {
        "message": "Flutter Backend API",
        "version": "1.0.0",
        "endpoints": {
            "auth": ["/api/register", "/api/login", "/api/logout", "/api/me"],
            "items": ["/api/items"]
        }
    }

if __name__ == "__main__":
    print("Database initialized")
    print("Starting server on http://localhost:8000")
    print("API docs available at http://localhost:8000/docs")
    uvicorn.run(app, host="0.0.0.0", port=8000)
