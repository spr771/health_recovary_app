import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/myorders.dart';
import 'package:health_recovary_app/viewcart.dart';

class orders extends StatefulWidget {
  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> {
  QuerySnapshot product;
  getproducts(String str) async {
    product = await firestore
        .collection("orders")
        .where("product_type", isEqualTo: str)
        .get();
    setState(() {
      product = product;
    });
  }

  String dropdownValue = 'oxygen';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproducts(dropdownValue);
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
                  getproducts(dropdownValue);
                });
              },
              items: <String>['oxygen', 'blood', 'food', 'bed', 'ambulance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => viewcart()));
                },
                child: Text("View Cart")),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(height: 10),
            ButtonTheme(
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                color: Colors.lightBlue.shade300,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => myorders()));
                },
                child: Text(
                  "My Orders",
                  style: TextStyle(fontSize: 20, letterSpacing: 1),
                ),
              ),
            ),
            SizedBox(height: 10),
            product != null && product.size != 0
                ? ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.size,
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
                                  product.docs[index].data()['product_name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  product.docs[index].data()['description'],
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                Divider(color: Colors.lightBlue.shade300),
                                Row(
                                  children: [
                                    Text(
                                      "Rs. " +
                                          product.docs[index]
                                              .data()['price']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    RaisedButton(
                                        onPressed: () async {
                                          await firestore
                                              .collection('users')
                                              .doc(user.uid)
                                              .update({
                                            "cart": FieldValue.arrayUnion(
                                                [product.docs[index].id])
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Item added to cart",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        },
                                        color: Colors.lightBlue.shade300,
                                        child: Text("Add To Cart")),
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
