void main() async
{ 
  print("Future Example Started");
  try {
  String data= await fetchData(); // wait for the future to complete 
  print(data); // this will execute after the future is complete
    
  } catch (e) {
    print("An error occurred: $e, Retrying again ...",);
  }
  finally{
    print("Execution Completed");
  }
  print("Future Example Ended"); 
}

Future<String> fetchData() async
{
  await Future.delayed(Duration(seconds: 2));
  throw Exception("Data fetch failed"); // Simulate an error 
  return "Next Execution after Data Load";
} 