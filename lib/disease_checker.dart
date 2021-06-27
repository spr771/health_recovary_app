import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_recovary_app/doctorlist.dart';
import 'package:health_recovary_app/myprofile.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class DiseaseChecker extends StatefulWidget {
  @override
  _DiseaseCheckerState createState() => _DiseaseCheckerState();
}

class _DiseaseCheckerState extends State<DiseaseChecker> {
  List<int> selectedItems = [];
  List<DropdownMenuItem<dynamic>> items = [];
  QuerySnapshot diseases;
  List<String> symptoms = [];
  QuerySnapshot doctorlist;
  bool vis = false;
  List<String> myDiseases = [];
  getdoctors(List<String> diseases) async {
    doctorlist = await FirebaseFirestore.instance
        .collection('doctors')
        .where('disease', arrayContainsAny: diseases)
        .get();
    for (var item in doctorlist.docs) {
      print(item.data().toString());
    }
  }

  getDiseaseSymptoms() async {
    diseases = await FirebaseFirestore.instance.collection('disease').get();
    for (int i = 0; i < diseases.size; i++) {
      for (int j = 0; j < diseases.docs[i].data()['symptoms'].length; j++) {
        if (!symptoms.contains(diseases.docs[i].data()['symptoms'][j])) {
          symptoms.add(diseases.docs[i].data()['symptoms'][j]);
          items.add(new DropdownMenuItem(
            child: Text(diseases.docs[i].data()['symptoms'][j]),
            value: diseases.docs[i].data()['symptoms'][j],
          ));
        }
      }
    }
    setState(() {
      diseases = diseases;
      items = items;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDiseaseSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    print(myDiseases.toString());

    return diseases != null
        ? Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    "Find Diseases",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 35,
                        color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => myprofile()));
                    },
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              backgroundColor: Colors.lightBlue.shade300,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(),
                  SearchableDropdown.multiple(
                    items: items,
                    selectedItems: selectedItems,
                    hint: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Select any"),
                    ),
                    searchHint: "Select any",
                    onChanged: (value) {
                      setState(() {
                        selectedItems = value;
                      });
                      print(selectedItems.toString());
                    },
                    closeButton: (selectedItems) {
                      return (selectedItems.isNotEmpty
                          ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                          : "Save without selection");
                    },
                    isExpanded: true,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.lightBlue.shade300),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height / 20),
                                side: BorderSide(color: Colors.white)))),
                    onPressed: () {
                      myDiseases = [];
                      for (int i = 0; i < selectedItems.length; i++) {
                        for (int j = 0; j < diseases.size; j++) {
                          var s = symptoms[selectedItems[i]];
                          if (diseases.docs[j].data()['symptoms'].contains(s)) {
                            String d = diseases.docs[j]
                                .data()['disease_name']
                                .toString();
                            if (!myDiseases.contains(d)) {
                              myDiseases.add(d);
                            }
                          }
                        }
                      }
                      getdoctors(myDiseases);
                      setState(() {
                        vis = true;
                      });
                    },
                    child: Text('Check Disease'),
                  ),
                  Visibility(
                      visible: vis,
                      child: Column(
                        children: [
                          Text(
                            myDiseases.join('\n'),
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.lightBlue.shade300),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20),
                                          side: BorderSide(
                                              color: Colors.white)))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Doctorlist(
                                              doctorlist: doctorlist,
                                            )));
                              },
                              child: Text('Find Doctor'))
                        ],
                      )),
                ],
              )),
            ),
          )
        : Scaffold(
            body: Text('Loading...'),
          );
  }
}
