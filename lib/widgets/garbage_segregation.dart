import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/screens/login_screen.dart';
import 'package:gdsc_solution_challenge/services/auth_service.dart';
import 'package:gdsc_solution_challenge/widgets/loader.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GarbageMenu extends StatelessWidget {
  // route name
  static const routeName = '/garbage_sorting';

  // constructor
  const GarbageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Some Error Occured'),
          );
        } else if (snapshot.hasData) {
          return const GarbageMenuLoggedIn();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class GarbageMenuLoggedIn extends StatefulWidget {
  const GarbageMenuLoggedIn({Key? key}) : super(key: key);

  @override
  State<GarbageMenuLoggedIn> createState() => _GarbageMenuLoggedInState();
}

class _GarbageMenuLoggedInState extends State<GarbageMenuLoggedIn> {
  File? _pickedImage;
  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Garbage Sorting'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GarbageCamera()));
                },
                child: GlassContainer.frostedGlass(
                  height: 150,
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(5),
                  borderRadius: BorderRadius.circular(20),
                  borderWidth: 2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        FittedBox(
                          child: Text(
                            "Open Camera",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.camera_alt,
                          size: 48,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ImageInput(onImageSelected: _selectImage),
            ],
          ),
        ),
      ),
    );
  }
}

class GarbageCamera extends StatefulWidget {
  const GarbageCamera({Key? key}) : super(key: key);

  @override
  State<GarbageCamera> createState() => _GarbageCameraState();
}

class _GarbageCameraState extends State<GarbageCamera> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    // initialize cameras.
    cameras = await availableCameras();
    // initialize camera controllers.
    controller = CameraController(cameras[0], ResolutionPreset.max);

    _initializeControllerFuture = controller.initialize();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Ensure that the camera is initialized.
          await _initializeControllerFuture;

          // Attempt to take a picture and get the file `image`
          // where it was saved.
          final image = await controller.takePicture();

          final inputImage = InputImage.fromFilePath(image.path);

          final imageLabeler = GoogleMlKit.vision.imageLabeler();

          final List<ImageLabel> labels =
              await imageLabeler.processImage(inputImage);

          // If the picture was taken, display it on a new screen.
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisplayLabels(
                labels: labels,
              ),
            ),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayLabels extends StatelessWidget {
  final List<ImageLabel> labels;

  const DisplayLabels({
    Key? key,
    required this.labels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(labels[index].label),
                    subtitle: Text(labels[index].confidence.toString()),
                  );
                },
              ),
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
  Future<void> _getImage() async {
    final _picker = ImagePicker();

    final image =
        await _picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);

      final imageLabeler = GoogleMlKit.vision.imageLabeler();

      final List<ImageLabel> labels =
          await imageLabeler.processImage(inputImage);

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayLabels(
            labels: labels,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getImage,
      child: GlassContainer.frostedGlass(
        height: 150,
        width: double.maxFinite,
        margin: const EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(20),
        borderWidth: 2,
        child: Container(
          margin: const EdgeInsets.only(top: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              FittedBox(
                child: Text(
                  "Browse Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.file_present,
                size: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
