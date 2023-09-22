import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerDemo extends StatefulWidget {
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // // Positioned(
            // //   top: 100,
            // Text(
            //   // "${selectedDate.toLocal()}".split(' ')[0],
            //   DateFormat('dd/mm/yyyy').format(selectedDate),
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //   // ),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  DateFormat('dd/mm/yyyy').format(selectedDate),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
            ) ,
          ],
        ),
      ),
    );
  }
}