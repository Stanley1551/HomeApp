import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final IconData icon;
  final bool isYesNoQuestion;

  CustomDialog(this.message, this.icon, {this.isYesNoQuestion = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.redAccent, style: BorderStyle.solid),
      ),
      backgroundColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(icon, color: Colors.red),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      message,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _getButtons(context))
          ],
        ),
      ),
    );
  }

  List<RaisedButton> _getButtons(BuildContext context) {
    List<RaisedButton> buttons = new List<RaisedButton>();

    buttons.add(RaisedButton(
      child: Text('OK'),
      onPressed: () => Navigator.of(context).pop(true),
    ));

    if (isYesNoQuestion) {
      buttons.add(RaisedButton(
        child: Text('No'),
        onPressed: () => Navigator.of(context).pop(false),
      ));
    }

    return buttons;
  }
}
