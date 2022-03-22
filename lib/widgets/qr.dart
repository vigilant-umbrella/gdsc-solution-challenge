import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/screens/login_screen.dart';
import 'package:gdsc_solution_challenge/services/auth_service.dart';
import 'package:gdsc_solution_challenge/widgets/loader.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatelessWidget {
  // route name
  static const routeName = '/attendance_qr';

  // constructor
  const GenerateQR({Key? key}) : super(key: key);

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
          return const GenerateQRLoggedIn();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class GenerateQRLoggedIn extends StatefulWidget {
  const GenerateQRLoggedIn({Key? key}) : super(key: key);

  @override
  State<GenerateQRLoggedIn> createState() => _GenerateQRLoggedInState();
}

class _GenerateQRLoggedInState extends State<GenerateQRLoggedIn> {
  String qrData = "https://www.google.com/";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Attendance QR Code")),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QrImage(data: qrData),
              ElevatedButton.icon(
                icon: const Icon(Icons.print),
                label: const Text("Print QR"),
                onPressed: () async {
                  final doc = pw.Document();

                  doc.addPage(
                    pw.Page(
                      build: (pw.Context context) {
                        return pw.Center(
                          child: pw.BarcodeWidget(
                            data: qrData,
                            barcode: pw.Barcode.qrCode(),
                            width: 200,
                            height: 200,
                          ),
                        );
                      },
                    ),
                  );

                  await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => doc.save());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: const Size.fromHeight(35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
