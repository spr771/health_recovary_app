import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';

class viewcart extends StatefulWidget {
  @override
  _viewcartState createState() => _viewcartState();
}

class _viewcartState extends State<viewcart> {
  List<Map<String, dynamic>> viewcart = [];
  // bool showspinner=true;
  DocumentSnapshot cartid;
  getviewcart() async {
    viewcart = [];
    cartid = await firestore.collection('users').doc(user.uid).get();
    for (var item in cartid.data()['cart']) {
      DocumentSnapshot cartloop =
          await firestore.collection("orders").doc(item).get();
      var cartloopdata = cartloop.data();
      cartloopdata['id'] = item;
      viewcart.add(cartloopdata);
    }
    setState(() {
      // showspinner=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getviewcart();
  }

  @override
  Widget build(BuildContext context) {
    print(viewcart.toString());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("My Cart"),
            Spacer(),
            cartid != null && cartid.data()['cart'].length != 0
                ? ElevatedButton(
                    onPressed: () async {
                      await firestore
                          .collection('users/${user.uid}/order')
                          .add({
                        'ordertime': FieldValue.serverTimestamp(),
                        'items': cartid.data()['cart']
                      });
                      await firestore
                          .collection('users')
                          .doc(user.uid)
                          .update({'cart': []});
                      Fluttertoast.showToast(
                          msg: "Ordered Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    },
                    child: Text("Place Order"))
                : SizedBox()
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
            children: [
              SizedBox(height: 10),
              viewcart != null && viewcart.length != 0
                  ? ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewcart.length,
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
                                    viewcart[index]['product_name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    viewcart[index]['description'],
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  Divider(color: Colors.lightBlue.shade300),
                                  Row(
                                    children: [
                                      Text(
                                        "Rs. " +
                                            viewcart[index]['price'].toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            print(viewcart[index]['id']);
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user.uid)
                                                .update({
                                              'cart': FieldValue.arrayRemove(
                                                  [viewcart[index]['id']])
                                            });
                                            await getviewcart();
                                          }),
                                    ],
                                  ),
                                  Divider(color: Colors.lightBlue.shade300),
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
            ],
          ),
        ),
      ),
    );
  }
}
