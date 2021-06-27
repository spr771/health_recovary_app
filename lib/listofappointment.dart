import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:intl/intl.dart';

class appointment extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<appointment> {
  QuerySnapshot appointment;
  getappointment() async {
    appointment = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('doctor')
        .get();
    setState(() {
      appointment = appointment;
      print(appointment.size);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getappointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Of Appointment"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              appointment != null && appointment.size != 0
                  ? ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appointment.size,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(),
                                  Text(
                                    appointment.docs[index].data()['name'],
                                    style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontSize: 23),
                                  ),
                                  Text(
                                    DateFormat('EEE, dd MMM yyyy H:mm').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          appointment.docs[index]
                                                  .data()['time']
                                                  .seconds *
                                              1000),
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    appointment.docs[index]
                                        .data()['fees']
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
