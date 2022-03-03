import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:intl/intl.dart';
import 'package:gdsc_solution_challenge/widgets/multiple_select_drop_down.dart';
import 'package:provider/provider.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({Key? key}) : super(key: key);

  // route name
  static const routeName = '/new_event_form';

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateinput = TextEditingController();
  final _timeinput = TextEditingController();
  final _locationController = TextEditingController();
  final _imageController = TextEditingController();
  List<String> _tags = [];

  @override
  void dispose() {
    _nameController.dispose();
    _dateinput.dispose();
    _timeinput.dispose();
    _locationController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add new event'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Event Name',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              autofocus: true,
                              controller: _nameController,
                            ),
                          ),
                        ),
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _dateinput,
                              decoration: const InputDecoration(
                                hintText: 'Date',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    _dateinput.text = formattedDate;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please choose a date.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _timeinput,
                              decoration: const InputDecoration(
                                hintText: 'Time',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (pickedTime != null) {
                                  setState(() {
                                    _timeinput.text =
                                        pickedTime.format(context);
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please choose a time.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Location',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              autofocus: true,
                              controller: _locationController,
                            ),
                          ),
                        ),
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> selectedTags) {
                                setState(() {
                                  _tags = selectedTags;
                                });
                              },
                              options: const ['Trees', 'Ocean'],
                              selectedValues: _tags,
                              whenEmpty: 'Select Tags',
                            ),
                          ),
                        ),
                        GlassContainer.frostedGlass(
                          height: 60,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Image',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              autofocus: true,
                              controller: _imageController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GlassContainer.frostedGlass(
                      height: 60,
                      width: double.maxFinite,
                      margin: const EdgeInsets.all(5),
                      borderRadius: BorderRadius.circular(20),
                      borderWidth: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        extendBody: true,
      ),
    );
  }
}
