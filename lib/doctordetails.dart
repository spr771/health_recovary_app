import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:intl/intl.dart';

class DoctorDetails extends StatefulWidget {
  String doctorid;
  Map<String, dynamic> doctordetails;
  DoctorDetails({this.doctorid, this.doctordetails});
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  var date = DateTime.now();
  DateFormat dateformat = DateFormat('yyyy-MM-dd HH:mm');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctordetails['name']),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.doctordetails['name'].toUpperCase(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.doctordetails['disease'].toList().join(", "),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Fees " + widget.doctordetails['fees'].toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Date Of Appointment: ' + dateformat.format(date),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Andika New Basic'),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              var selectedDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2020 - 5),
                  lastDate: DateTime(2020 + 5));
              if (selectedDate != null) {
                print('$selectedDate');
              }
              var selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: date.hour, minute: date.minute));
              if (selectedTime != null) {
                print('$selectedTime');
              }
              setState(() {
                date = DateTime(selectedDate.year, selectedDate.month,
                    selectedDate.day, selectedTime.hour, selectedTime.minute);
              });
            },
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlue.shade300),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height / 20),
                          side: BorderSide(color: Colors.white)))),
              onPressed: () async {
                await firestore
                    .collection('users')
                    .doc(user.uid)
                    .collection('doctor')
                    .add({
                  'fees': widget.doctordetails['fees'],
                  'name': widget.doctordetails['name'],
                  "time": date,
                });
                Fluttertoast.showToast(
                    msg: "Appointment is confirm",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              },
              child: Text("Book An Appoinment"))
        ],
      ),
    );
  }
}
