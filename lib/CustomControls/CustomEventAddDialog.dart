import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class CustomEventAddDialog extends StatelessWidget {
  DateTime initialDay;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  final Function(String title, DateTime eventTime) finishCallback;
  CustomEventAddDialog(this.initialDay, this.finishCallback) {
    //normalizing date...
    this.initialDay = this.initialDay.subtract(Duration(hours: 12));
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.blueAccent, style: BorderStyle.solid),
        ),
        backgroundColor: Colors.black87,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'New event',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: 'Event title',
                      hintStyle:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 13)),
                ),
                DateTimePicker(
                  type: DateTimePickerType.time,
                  icon: Icon(Icons.access_time),
                  controller: _timeController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: RaisedButton(
                    onPressed: () => _savePressed(
                        context, _titleController, _timeController),
                    child: Text('Save'),
                  ),
                )
              ],
            )));
  }

  void _savePressed(BuildContext context, TextEditingController titleController,
      TextEditingController timeController) {
    //TODO validate fields
    if (titleController.text.isNotEmpty && timeController.text.isNotEmpty) {
      Navigator.pop(context);
      var time = timeController.text.split(":");
      var eventDateTime = this.initialDay.add(
          Duration(hours: int.parse(time[0]), minutes: int.parse(time[1])));
      finishCallback(titleController.text,eventDateTime);
    }
  }
}
