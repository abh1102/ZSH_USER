import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

class PdfViewerScreen extends StatelessWidget {
  final File pdfPath;
  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Pdf", secondText: "View"),
      body: SfPdfViewer.file(pdfPath),
    );
  }
}
