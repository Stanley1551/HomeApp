import 'package:flutter/material.dart';

class CustomEventElement extends StatelessWidget {
  final String title;
  final DateTime time;

  CustomEventElement(this.title, this.time);
  @override
  Widget build(BuildContext context) {
    return Card(
        borderOnForeground: true,
        margin: EdgeInsets.all(10),
        child: Padding(
          child: Flex(direction: Axis.horizontal, children: [
            Expanded(child: Text(title)),
            Icon(Icons.access_alarm, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                time.hour.toString() + ':' + time.minute.toString(),
                style: TextStyle(color: Colors.grey),
              ),
            )
          ]),
          padding: EdgeInsets.only(bottom: 20, top: 20, left: 10, right: 10),
        ),
        shadowColor: Colors.grey,
        color: Color.fromARGB(190, 0, 0, 0),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(5))));
  }
}
