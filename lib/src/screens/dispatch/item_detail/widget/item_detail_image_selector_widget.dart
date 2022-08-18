import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/values/values.dart';

class ItemDetailImageSelectorWidget extends StatefulWidget {
  String? fileURL;
  final Function({String? itemImagePath, String? imageURI}) callback;

  ItemDetailImageSelectorWidget(this.fileURL, this.callback, {Key? key})
      : super(key: key);

  @override
  _ItemDetailImageSelectorWidgetState createState() =>
      _ItemDetailImageSelectorWidgetState();
}

class _ItemDetailImageSelectorWidgetState
    extends State<ItemDetailImageSelectorWidget> {
  File? file;

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
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null) {
      setState(() {
        file = File(result.files.first.path!);
      });

      doCallback();
    }
  }

  doCallback() => widget.callback(
      itemImagePath: file != null ? file!.path : null,
      imageURI: widget.fileURL);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: file == null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: InkWell(
            splashColor: Colors.black12.withAlpha(30),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: appPrimaryColor.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: widget.fileURL != null &&
                      widget.fileURL!.startsWith('http')
                  ? SizedBox(
                      width: 120,
                      height: 150,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: Radii.k8pxRadius,
                              child: CachedNetworkImage(
                                imageUrl: widget.fileURL ?? '',
                                height: 90.0,
                                width: 90,
                                placeholder: (context, url) => const SizedBox(
                                  height: 90.0,
                                  width: 90,
                                ),
                                errorWidget: (context, url, err) =>
                                    const SizedBox(
                                  height: 90.0,
                                  width: 90,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                setState(() => widget.fileURL = null);
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
                    )
                  : SizedBox(
                      width: 120,
                      height: 150,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Remix.upload_2_line),
                            const SizedBox(height: 5.0),
                            Text('Upload item image',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.caption!
                                    .copyWith(color: appPrimaryColor))
                          ]),
                    ),
            ),
            onTap: uploadItemImage,
          ),
          secondChild: SizedBox(
            width: 120,
            height: 150,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: file == null
                      ? const SizedBox(
                          width: 120,
                          height: 150,
                        )
                      : ClipRRect(
                          borderRadius: Radii.k8pxRadius,
                          child: Image.file(
                            file!,
                            width: 120,
                            height: 150,
                            fit: BoxFit.cover,
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
    );
  }
}
