import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/doctordetails.dart';
import 'package:health_recovary_app/listofappointment.dart';

class Doctorlist extends StatelessWidget {
  QuerySnapshot doctorlist;
  Doctorlist({this.doctorlist});
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
              Text("Doctors"),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => appointment()));
                  },
                  child: Text("My Appointments"))
            ],
          )),
      body: ListView.builder(
          itemCount: doctorlist.size,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorDetails(
                                doctorid: doctorlist.docs[index].id,
                                doctordetails: doctorlist.docs[index].data(),
                              )));
                },
                child: ListTile(
                    subtitle: Text(
                      doctorlist.docs[index]
                          .data()['disease']
                          .toList()
                          .join(', '),
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text(doctorlist.docs[index].data()['name'],
                        style: TextStyle(fontSize: 20))),
              ),
            );
          }),
    );
  }
}

listofappointment() {}
