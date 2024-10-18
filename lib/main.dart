import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Picker(),
    );
  }
}

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  // Store selected date, hour, and minute
  DateTime selectedDate = DateTime.now();
  int selectedHour = DateTime.now().hour;
  int selectedMinute = DateTime.now().minute;

  // Controller for the TextField
  TextEditingController dateTimeController = TextEditingController();

  // Get the current year
  int currentYear = DateTime.now().year;

  // Get the first and last date of the current year
  DateTime minDate = DateTime(DateTime.now().year, 1, 1);
  DateTime maxDate = DateTime(DateTime.now().year, 12, 31);

  @override
  void dispose() {
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Date & Time Picker'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField to show selected date and time
            TextField(
              controller: dateTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Select Date & Time',
                border: OutlineInputBorder(),
              ),
              onTap: () {
                _showDateTimePicker(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to show date & time picker
  void _showDateTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            // Button to confirm selection
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Update the TextField with the selected date & time
                  dateTimeController.text = _getFormattedDateTime();
                },
                icon: const Icon(Icons.check),
              ),
            ),

            SizedBox(
              height: 150,
              child: Row(
                children: [
                  // Date Picker
                  Expanded(
                    flex: 2,
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 30,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedDate = minDate.add(Duration(days: index));
                        });
                      },
                      children: List<Widget>.generate(
                        maxDate.difference(minDate).inDays + 1,
                        (int index) {
                          DateTime dateToShow =
                              minDate.add(Duration(days: index));
                          return Center(
                            child: Text(_getDateLabel(dateToShow)),
                          );
                        },
                      ),
                    ),
                  ),
                  // Hour Picker
                  Expanded(
                    flex: 1,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedHour),
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          selectedHour = value;
                        });
                      },
                      children: List<Widget>.generate(24, (int index) {
                        return Center(
                          child: Text(index.toString().padLeft(2, '0')),
                        );
                      }),
                    ),
                  ),
                  // Minute Picker
                  Expanded(
                    flex: 1,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedMinute),
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          selectedMinute = value;
                        });
                      },
                      children: List<Widget>.generate(60, (int index) {
                        return Center(
                          child: Text(index.toString().padLeft(2, '0')),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to format
  String _getFormattedDateTime() {
    final formattedDate = DateFormat('EEE dd MMM').format(selectedDate);
    final formattedTime =
        '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';
    return '$formattedDate $formattedTime';
  }

  // Function to display 'Today'
  String _getDateLabel(DateTime date) {
    final today = DateTime.now();
    if (date.day == today.day &&
        date.month == today.month &&
        date.year == today.year) {
      return 'Today';
    }
    return DateFormat('EEE dd MMM').format(date);
  }
}
