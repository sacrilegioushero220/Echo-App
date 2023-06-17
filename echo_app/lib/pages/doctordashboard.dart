import 'package:flutter/material.dart';

class DoctorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/doctor_avatar.png'),
                ),
                SizedBox(height: 8),
                Text(
                  'Dr. John Doe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Cardiologist'),
                SizedBox(height: 4),
                Text('ABC Hospital'),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPatientList('Critical Patients', Colors.red, [
                      'Patient 1',
                      'Patient 2',
                      'Patient 3',
                    ]),
                    SizedBox(width: 16),
                    _buildPatientList('Non-critical Patients', Colors.green, [
                      'Patient 4',
                      'Patient 5',
                      'Patient 6',
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientList(String title, Color color, List<String> patients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          color: color,
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: patients
                  .map((patient) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/patient_avatar.png'),
                            ),
                            SizedBox(height: 4),
                            Text(patient),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
