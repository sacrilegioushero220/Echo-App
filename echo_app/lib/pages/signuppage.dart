import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isDoctorSelected = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> saveDataToFirestore({
    required String name,
    required String dob,
    required String gender,
    required String address,
    required String mobile,
    required String email,
    required bool isDoctorSelected,
    required String hospitalName,
    required String specialization,
  }) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('users');
      await collectionRef.add({
        'name': name,
        'dob': dob,
        'gender': gender,
        'address': address,
        'mobile': mobile,
        'email': email,
        'isDoctorSelected': isDoctorSelected,
        'hospitalName': hospitalName,
        'specialization': specialization,
      });

      // Data saved successfully
      print('Data saved to Firestore!');
      showSnackbar('Signup successful', Colors.green);
      // Navigate back to the login page after successful signup
      Navigator.pop(context);
    } catch (e) {
      // Error saving data
      print('Error saving data to Firestore: $e');
      showSnackbar('Signup failed', Colors.red);
    }
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: isDoctorSelected,
                    onChanged: (value) {
                      setState(() {
                        isDoctorSelected = value!;
                      });
                    },
                  ),
                  Text('Doctor'),
                  SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                    value: !isDoctorSelected,
                    onChanged: (value) {
                      setState(() {
                        isDoctorSelected = !value!;
                      });
                    },
                  ),
                  Text('Patient'),
                ],
              ),
              SizedBox(height: 20),
              Visibility(
                visible: isDoctorSelected,
                child: TextFormField(
                  controller: hospitalNameController,
                  decoration: InputDecoration(
                    labelText: 'Name of Hospital',
                    prefixIcon: Icon(Icons.local_hospital),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: isDoctorSelected,
                child: TextFormField(
                  controller: specializationController,
                  decoration: InputDecoration(
                    labelText: 'Specialization',
                    prefixIcon: Icon(Icons.school),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  saveDataToFirestore(
                    name: nameController.text,
                    dob: dobController.text,
                    gender: genderController.text,
                    address: addressController.text,
                    mobile: mobileController.text,
                    email: emailController.text,
                    isDoctorSelected: isDoctorSelected,
                    hospitalName: hospitalNameController.text,
                    specialization: specializationController.text,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
