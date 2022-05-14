import 'package:event_counter/models/event.dart';
import 'package:event_counter/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  static const String routeName = '/add';

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  DateTime _boughtDate = new DateTime.now();

  final _datePickercontroller = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
  );

  Event _newEvent = Event(
    id: 1,
    name: '',
    description: '',
    deadline: DateTime.now(),
  );

  Future<void> _showPicker(BuildContext context) async {
    _boughtDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030)) as DateTime;

    _datePickercontroller.text = DateFormat('yyyy-MM-dd').format(_boughtDate);
  }

  bool _savePost() {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return false;
    }

    _form.currentState!.save();
    // Provider.of<Events>(context, listen: false).addEvent(_newEvent);

    Box<Event> box = Hive.box<Event>('events');

    box.add(_newEvent);

    Navigator.of(context).pop();
    // Navigator.of(context).pop();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event name',
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _newEvent = Event(
                      id: _newEvent.id,
                      name: value,
                      description: _newEvent.description,
                      deadline: _newEvent.deadline,
                    );
                  },
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Event description',
                  ),
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _newEvent = Event(
                      id: _newEvent.id,
                      name: _newEvent.name,
                      description: value,
                      deadline: _newEvent.deadline,
                    );
                  },
                ),
                TextFormField(
                  controller: _datePickercontroller,
                  // initialValue: _datePickercontroller.text,
                  decoration: InputDecoration(
                    labelText: 'Event Deadline',
                    // suffix: IconButton(
                    //   // onPressed: _showPicker,
                    //   tooltip: 'Tap to open datePicker',
                    //   onPressed: () {
                    //     DatePickerDialog(
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2000),
                    //       lastDate: DateTime(2025),
                    //     );
                    //   },
                    //   icon: Icon(Icons.calendar_view_day_rounded),
                    // ),
                    suffix: IconButton(
                      icon: Icon(Icons.calendar_today),
                      tooltip: 'Tap to open date picker',
                      onPressed: () {
                        _showPicker(context);

                        // _datePickercontroller.text = _boughtDate.toString();
                      },
                    ),
                  ),
                  onSaved: (value) {
                    _newEvent = Event(
                      id: _newEvent.id,
                      name: _newEvent.name,
                      description: _newEvent.description,
                      // deadline: value as DateTime,
                      deadline: DateTime.parse(value as String),
                      // deadline: DateTime.parse(value.toString()),
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Add event'),
                  onPressed: () {
                    _savePost();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.check),
      // ),
    );
  }
}
