import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class contactlist extends StatefulWidget {
  @override
  _contactlistState createState() => _contactlistState();
}

class _contactlistState extends State<contactlist> {
  QuerySnapshot contact;
  getcontact(String str) async {
    contact = await firestore
        .collection('contacts')
        .where('disease', isEqualTo: str)
        .get();
    setState(() {
      contact = contact;
    });
  }

  String dropdownValue = 'Dengue';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcontact(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.lightBlue.shade300,
        title: Row(
          children: [
            Text("Government Contact No"),
            Spacer(),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue;
                  getcontact(dropdownValue);
                });
              },
              items: <String>[
                'Covid19',
                'Thalassemia',
                'Dengue',
                'Malaria',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(height: 10),
            contact != null && contact.size != 0
                ? ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: contact.size,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      contact.docs[index].data()['disease'] +
                                          ":  ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      contact.docs[index].data()['contact'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.lightBlue.shade300),
                              ]),
                        ),
                      );
                    },
                  )
                : Container(),
          ],
        )),
      ),
    );
  }
}
