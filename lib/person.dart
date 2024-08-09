import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'database.dart';
import 'constant.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Employee',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5,
                ),
              ],
            ),
            children: [
              TextSpan(
                text: ' Form',
                style: TextStyle(
                  color: Color(0xffFF512F),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffA54A69),
                Color(0xffC5A290),
                Color(0xffA54A69),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffA54A69),
              Color(0xffC5A290),
              Color(0xffA54A69),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 30, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: tstyle,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Age',
                  style: tstyle,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Age',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Location',
                  style: tstyle,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter Location',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: tstyle,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    Map<String, dynamic> employeeMap = {
                      'Name': nameController.text,
                      'Age': ageController.text,
                      'Location': locationController.text,
                      'Phone': phoneController.text,
                    };

                    await databaseMethods.addEmployeeDetails(
                        employeeMap, randomAlphaNumeric(10));

                    Fluttertoast.showToast(msg: "Employee added successfully");

                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(2.0, 2.0),
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffA54A69),
                          Color(0xffC5A290),
                          Color(0xffA54A69)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Save Employee Details",
                      style: TextStyle(
                        // color: Color(0xffFF512F),
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
