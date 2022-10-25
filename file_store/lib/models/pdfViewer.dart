import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class pdfViewer extends StatefulWidget {
  String pdfPath;
  pdfViewer({this.pdfPath});
  @override
  _pdfViewerState createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: wi,
      height: he,
      child: PDFViewerScaffold(
        path: widget.pdfPath,
      ),
    ));
  }
}
