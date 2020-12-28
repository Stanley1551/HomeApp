import 'package:flutter/material.dart';
import 'package:homeapp/Services/AppLocalization.dart';

class CustomTextEntryDialog extends StatelessWidget {
  final String message;
  final IconData icon;
  final Function(String) submitCallback;
  final TextEditingController teController = TextEditingController();

  CustomTextEntryDialog(this.message, this.icon, {this.submitCallback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue, style: BorderStyle.solid),
      ),
      backgroundColor: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  message,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextField(
              controller: teController,
            ),
            Container(
              height: 10,
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
      child: Text(AppLocalization.of(context).submit),
      onPressed: () {
        if (submitCallback != null) {
          submitCallback(teController.text);
        }
        Navigator.of(context).pop(true);
      },
    ));
    return buttons;
  }
}
