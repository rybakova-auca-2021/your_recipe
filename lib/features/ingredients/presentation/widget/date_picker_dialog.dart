import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerBottomSheet extends StatelessWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DatePickerBottomSheet({
    Key? key,
    required this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Select Date',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              initialDateTime: initialDate,
              minimumYear: 2000,
              maximumYear: 3000,
              onDateTimeChanged: (DateTime newDate) {
                onDateSelected(newDate);
              },
              mode: CupertinoDatePickerMode.date,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
