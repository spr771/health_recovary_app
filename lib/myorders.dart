import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class myorders extends StatefulWidget {
  @override
  _myordersState createState() => _myordersState();
}

class _myordersState extends State<myorders> {
  bool showspinner = true;
  QuerySnapshot orders;
  List<List<DocumentSnapshot>> items = [];
  getorders() async {
    orders = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('order')
        .orderBy("ordertime", descending: true)
        .get();
    for (int i = 0; i < orders.size; i++) {
      List<DocumentSnapshot> temp = [];
      for (int j = 0; j < orders.docs[i].data()['items'].length; j++) {
        temp.add(await firestore
            .collection('orders')
            .doc(orders.docs[i].data()['items'][j])
            .get());
      }
      items.add(temp);
    }

    setState(() {
      orders = orders;
      items = items;
      showspinner = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getorders();
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
        title: Text("My Orders"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: [
            orders != null && orders.size != 0
                ? ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orders.size,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('EEE, dd MMM yyyy H:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(orders
                                            .docs[index]
                                            .data()['ordertime']
                                            .seconds *
                                        1000),
                                  ),
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 20),
                                ),
                                items != null && items.length != 0
                                    ? ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: items[index].length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Card(
                                            elevation: 15,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 15),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      items[index][i]
                                                          ['product_name'],
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      items[index][i]
                                                          ['description'],
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    Divider(
                                                        color: Colors.lightBlue
                                                            .shade300),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Rs. " +
                                                              items[index][i]
                                                                      ['price']
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                    Divider(
                                                        color: Colors.lightBlue
                                                            .shade300),
                                                  ]),
                                            ),
                                          );
                                        },
                                      )
                                    : SizedBox(),
                              ]),
                        ),
                      );
                    },
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: Text(
                        "No Items Here",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
          ])),
        ),
      ),
    );
  }
}
