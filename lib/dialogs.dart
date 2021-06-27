import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class dialogs {
  static Future<DialogAction> yesabortdialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.warning,
                  color: Colors.blue.shade300,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    letterSpacing: 3,
                    fontFamily: 'Andika New Basic',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black87),
              ),
            ],
          ),
          content: Text(
            body,
            style: TextStyle(
                fontFamily: 'Andika New Basic',
                fontSize: 20,
                color: Colors.black87),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text(
                'No',
                style: TextStyle(
                    fontFamily: 'Andika New Basic',
                    color: Colors.blue,
                    fontSize: 20),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(5),
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes',
                style: TextStyle(fontFamily: 'Andika New Basic', fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
