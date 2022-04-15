import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

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
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Event description',
                  ),
                  keyboardType: TextInputType.multiline,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event deadline',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Add event'),
                  onPressed: () {},
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
