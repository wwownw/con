import 'dart:io';
import 'package:con/document/pdfapi.dart';
import 'package:path/path.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';
    return Scaffold(
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        actions: pages >= 2
            ? [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      final page = indexPage == 0 ? pages : indexPage - 1;
                      controller.setPage(page);
                    },
                    icon: const Icon(Icons.chevron_left)),
                IconButton(
                    onPressed: () {
                      final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                      controller.setPage(page);
                    },
                    icon: const Icon(Icons.chevron_right)),
                const SizedBox(width: 8)
              ]
            : null,
        title: Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: PDFView(
        filePath: widget.file.path,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage as int),
      ),
    );
  }
}
