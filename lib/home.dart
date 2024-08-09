import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/person.dart';
import 'database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot>? employeeStream;
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  void initState() {
    super.initState();
    employeeStream = FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  Future<void> _editEmployeeDetails(String id, Map<String, dynamic> updatedInfo) async {
    await databaseMethods.updateEmployeeDetails(id, updatedInfo);
  }

  Future<void> _deleteEmployee(String id) async {
    await databaseMethods.deleteEmployee(id);
  }

  void _showEditDialog(DocumentSnapshot ds) {
    TextEditingController nameController = TextEditingController(text: ds['Name']);
    TextEditingController ageController = TextEditingController(text: ds['Age']);
    TextEditingController locationController = TextEditingController(text: ds['Location']);
    TextEditingController phoneController = TextEditingController(text: ds['Phone']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Employee"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: "Age"),
                ),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: "Location"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _editEmployeeDetails(ds.id, {
                  'Name': nameController.text,
                  'Age': ageController.text,
                  'Location': locationController.text,
                  'Phone': phoneController.text,
                }).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget allEmployeeDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: employeeStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Employee Data Available"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffA54A69), Color(0xffC5A290), Color(0xffA54A69)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all( ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 12, // Increased blur for a more pronounced shadow
                    offset: Offset(0, 6), // Offset to create a slight lift effect
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffA54A69),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ds['Name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White color for better contrast
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Age: ${ds['Age']}\nLocation: ${ds['Location']}",
                          style: TextStyle(
                            color: Colors.white70, // Slightly lighter shade for the details
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      _showEditDialog(ds);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever_outlined, color: Color(0xffFF512F)),
                    onPressed: () {
                      _deleteEmployee(ds.id);
                    },
                  ),
                ],
              ),
            );

          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Person(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Color(0xffA54A69),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Flutter',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5)
                  ]),
              children: [
                TextSpan(
                  text: ' Firebase',
                  style: TextStyle(
                      color: Color(0xffFF512F),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5)
                      ]),
                )
              ]),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffA54A69), Color(0xffC5A290), Color(0xffA54A69)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffA54A69), Color(0xffC5A290), Color(0xffA54A69)],
          ),
        ),
        child: allEmployeeDetails(),
      ),
    );
  }
}
