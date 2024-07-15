import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime)? onDateSelected;

  const DatePickerWidget({
    Key? key,
    this.initialDate,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      widget.onDateSelected?.call(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   'Selected Date: ${selectedDate.toLocal()}',
        //   style: const TextStyle(fontSize: 18),
        // ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Select Date'),
        ),
      ],
    );
  }
}
