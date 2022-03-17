// ignore_for_file: unnecessary_const

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/models/location_model.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/widgets/multiple_select_drop_down.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  final _eventNameController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  // ignore: unused_field
  List<String> _eventTags = [];

  // ignore: unused_field
  File? _pickedImage;

  // ignore: unused_field
  Location? _pickedLocation;

  void getEventTags(List<String> tags) {
    _eventTags = tags;
  }

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectLocation(Location location) {
    _pickedLocation = location;
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
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
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // do something
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  FormGlassMorphicTextInput(
                    controller: _eventNameController,
                    labelText: 'Event name',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter event name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  FormGlassMorphicTextInput(
                    controller: _eventDescriptionController,
                    labelText: 'Event description',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter event description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: ((context, constraints) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GlassMorphicDateAndTime(
                              width: (constraints.maxWidth / 2) - 5,
                            ),
                            GlassMorphicTimePicker(
                                width: (constraints.maxWidth / 2) - 5),
                          ],
                        )),
                  ),
                  const SizedBox(height: 20),
                  LocationInput(onLocationSelected: _selectLocation),
                  const SizedBox(height: 20),
                  ImageInput(onImageSelected: _selectImage),
                  const SizedBox(height: 20),
                  DropDownMultiSelect(
                    onSelected: getEventTags,
                  ),
                ],
              ),
            ),
          ),
        ),
        extendBody: true,
      ),
    );
  }
}

class FormGlassMorphicTextInput extends StatelessWidget {
  final String _labelText;
  final Function _validator;
  final TextEditingController _controller;

  const FormGlassMorphicTextInput(
      {Key? key,
      required String labelText,
      required Function validator,
      required TextEditingController controller})
      : _labelText = labelText,
        _validator = validator,
        _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      height: 75,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        controller: _controller,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: _labelText,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        validator: (value) => _validator(value),
      ),
    );
  }
}

class GlassMorphicDateAndTime extends StatefulWidget {
  final double width;
  const GlassMorphicDateAndTime({Key? key, required this.width})
      : super(key: key);

  @override
  State<GlassMorphicDateAndTime> createState() =>
      _GlassMorphicDateAndTimeState();
}

class _GlassMorphicDateAndTimeState extends State<GlassMorphicDateAndTime> {
  DateTime? _selectedDate;

  void _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showDatePicker,
      child: GlassContainer.frostedGlass(
        height: 55,
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _selectedDate == null
                    ? 'Select date'
                    : DateFormat('dd MMM, yyyy').format(_selectedDate!),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class GlassMorphicTimePicker extends StatefulWidget {
  final double width;
  const GlassMorphicTimePicker({Key? key, required this.width})
      : super(key: key);

  @override
  State<GlassMorphicTimePicker> createState() => _GlassMorphicTimePickerState();
}

class _GlassMorphicTimePickerState extends State<GlassMorphicTimePicker> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (selectedTime != null) {
          setState(() {
            _selectedTime = selectedTime;
          });
        }
      },
      child: GlassContainer.frostedGlass(
        height: 55,
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _selectedTime == null
                    ? 'Select time'
                    : _selectedTime!.format(context),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.access_time,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageInput extends StatefulWidget {
  final Function onImageSelected;
  const ImageInput({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  Future<void> _getImage() async {
    final _picker = ImagePicker();

    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedFile != null) {
      final File selectedFile = File(pickedFile.path);
      setState(() {
        _imageFile = selectedFile;
      });
      widget.onImageSelected(selectedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getImage,
      child: GlassContainer.frostedGlass(
        height: 200,
        width: double.maxFinite,
        padding: const EdgeInsets.all(2),
        borderRadius: BorderRadius.circular(8),
        child: _imageFile == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.add_a_photo,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add image',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onImageSelected(null);
                        setState(() {
                          _imageFile = null;
                        });
                      },
                      icon: const Icon(Icons.remove_circle_outline_rounded),
                      label: const Text('Remove'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class LocationInput extends StatefulWidget {
  final Function onLocationSelected;

  const LocationInput({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? pickedLocation;

  Future<void> _selectOnMap() async {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectOnMap,
      child: GlassContainer.frostedGlass(
        height: 55,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                child: Text(
                  pickedLocation == null
                      ? 'Select location'
                      : pickedLocation!.address ?? 'No location selected',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
