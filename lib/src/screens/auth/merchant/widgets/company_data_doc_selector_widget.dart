import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';

class CompanyDataDocSelectorWidget extends StatefulWidget {
  final Function(String? itemImagePath) callback;

  const CompanyDataDocSelectorWidget(this.callback, {Key? key})
      : super(key: key);

  @override
  _CompanyDataDocSelectorWidgetState createState() =>
      _CompanyDataDocSelectorWidgetState();
}

class _CompanyDataDocSelectorWidgetState
    extends State<CompanyDataDocSelectorWidget> {
  double ratio = 4 / 5;

  File? file;
  bool isImage = true;
  String fileName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  uploadItemImage() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'docx', 'doc', 'pdf']);
    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null) {
      if (isFileMoreThanMaxInMB(File(result.files.first.path!))) {
        return;
      }
      setState(() {
        isImage = result.files.first.extension == 'png' ||
            result.files.first.extension == 'jpg' ||
            result.files.first.extension == 'jpeg';
        fileName = result.files.first.name;
        file = File(result.files.first.path!);
      });

      doCallback();
    }
  }

  doCallback() => widget.callback(file != null ? file!.path : null);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: file == null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: InkWell(
                splashColor: Colors.black12.withAlpha(30),
                child: AspectRatio(
                  aspectRatio: ratio,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: appPrimaryColor.withOpacity(0.3), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Remix.upload_2_line),
                          const SizedBox(height: 5.0),
                          Text('Upload CAC Certificate not more than 5mb',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.caption!
                                  .copyWith(color: appPrimaryColor))
                        ]),
                  ),
                ),
                onTap: uploadItemImage,
              ),
              secondChild: AspectRatio(
                aspectRatio: ratio,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: file == null
                          ? const SizedBox()
                          : isImage
                              ? ClipRRect(
                                  borderRadius: Radii.k8pxRadius,
                                  child: Image.file(
                                    file!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: appPrimaryColor.withOpacity(0.3),
                                        width: 1),
                                    borderRadius: Radii.k8pxRadius,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(fileName,
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.caption!
                                              .copyWith(
                                                  color: appPrimaryColor)),
                                    ),
                                  ),
                                ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          setState(() => file = null);
                          doCallback();
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: redColor,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
