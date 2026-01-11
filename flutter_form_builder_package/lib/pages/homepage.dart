import 'package:flutter/material.dart';

// EDIT: Created HomePage to display registration form data
class HomePage extends StatelessWidget {
  // EDIT: Added formData parameter to receive data from registration form
  final Map<String, dynamic> formData;

  const HomePage({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Registration Data",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // EDIT: Display Name from form data
            _buildDataRow("Name", formData['Name'] ?? "Not provided"),
            SizedBox(height: 15),
            // EDIT: Display Gender from form data
            _buildDataRow(
                "Gender", formData['Choose your gender'] ?? "Not provided"),
            SizedBox(height: 15),
            // EDIT: Display Checkbox status from form data
            _buildDataRow("Not Gay", _asDisplayString(formData['isGay'])),
            SizedBox(height: 15),
            // EDIT: Display Birth Date from form data (converted to string)
            _buildDataRow("Birth Date", _asDisplayString(formData['BirthDate'])),
            SizedBox(height: 15),
            // EDIT: Display Radio selection from form data
            _buildDataRow("Radio Selection", _asDisplayString(formData['Radio'])),
            SizedBox(height: 40),
            // EDIT: Added back button to return to form
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text("Back to Form"),
            ),
          ],
        ),
      ),
    );
  }

  // EDIT: Helper widget to display data in a consistent format
  Widget _buildDataRow(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // EDIT: Simpler function to convert form values to display string
  String _asDisplayString(dynamic value) =>
      value == null ? "Not provided" : value is DateTime ? "${value.toLocal()}".split(' ')[0] : value.toString();
}
