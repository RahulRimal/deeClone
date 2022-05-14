import 'package:event_counter/models/event.dart';
import 'package:event_counter/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  DateTime _boughtDate = new DateTime.now();

  Event _editedEvent = Event(
    id: 999,
    name: '',
    description: '',
    deadline: DateTime.now(),
  );

  final _datePickercontroller = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
  );

  Future<void> _showPicker(BuildContext context) async {
    _boughtDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030)) as DateTime;

    _datePickercontroller.text = DateFormat('yyyy-MM-dd').format(_boughtDate);
    // setState(() {
    //   _datePickercontroller.text = DateFormat('yyyy-MM-dd').format(_boughtDate);
    // });
  }

  bool _savePost(int key) {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return false;
    }

    _form.currentState!.save();
    // Provider.of<Events>(context, listen: false).addEvent(_editedEvent);
    // Provider.of<Events>(context, listen: false).updateEvent(_editedEvent);

    Box<Event> box = Hive.box('events');

    box.put(key, _editedEvent);

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    return true;
  }

  // @override
  // void didChangeDependencies() {
  //   _datePickercontroller.text = DateFormat('yyyy-MM-dd')
  //       .format(_editedEvent.deadline as DateTime)
  //       .toString();
  //   // _datePickercontroller.text = DateFormat('yyyy-MM-dd').format(_boughtDate);

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // final receivedEvent = ModalRoute.of(context)!.settings.arguments as Event;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final receivedEvent = args['event'] as Event;

    final _key = args['key'];

    _editedEvent = receivedEvent;

    _datePickercontroller.text = DateFormat('yyyy-MM-dd')
        .format(_editedEvent.deadline as DateTime)
        .toString();

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
                  initialValue: _editedEvent.name,
                  decoration: InputDecoration(
                    labelText: 'Event name',
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedEvent = Event(
                      id: _editedEvent.id,
                      name: value,
                      description: _editedEvent.description,
                      deadline: _editedEvent.deadline,
                    );
                  },
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  initialValue: _editedEvent.description,
                  decoration: InputDecoration(
                    labelText: 'Event description',
                  ),
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editedEvent = Event(
                      id: _editedEvent.id,
                      name: _editedEvent.name,
                      description: value,
                      deadline: _editedEvent.deadline,
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
                    _editedEvent = Event(
                      id: _editedEvent.id,
                      name: _editedEvent.name,
                      description: _editedEvent.description,
                      // deadline: value as DateTime,
                      deadline: DateTime.parse(value as String),
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Update event'),
                  onPressed: () {
                    _savePost(_key);
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
