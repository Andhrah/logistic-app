import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';

const vehicleImageKey = 'vehicle_image';

class AddRiderVehicleDocSelectorWidget extends StatefulWidget {
  final Function(Map<String, String> files) callback;

  const AddRiderVehicleDocSelectorWidget(this.callback, {Key? key})
      : super(key: key);

  @override
  _AddRiderVehicleDocSelectorWidgetState createState() =>
      _AddRiderVehicleDocSelectorWidgetState();
}

class _AddRiderVehicleDocSelectorWidgetState
    extends State<AddRiderVehicleDocSelectorWidget> {
  Map<String, String> files = {
    vehicleImageKey: '',
    'driver_license': '',
    'road_worthiness': '',
    'haulage_report': '',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  uploadItemImage(int index) async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'png',
      'jpg',
      'jpeg',
    ]);
    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null) {
      setState(() {
        files[files.keys.elementAt(index)] = result.files.first.path!;
      });

      doCallback();
    }
  }

  doCallback() => widget.callback(files);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: List.generate(
          files.length,
          (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: files.values.elementAt(index).isEmpty
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: InkWell(
                        splashColor: Colors.black12.withAlpha(30),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3.4,
                          height: MediaQuery.of(context).size.height / 8.7,
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appPrimaryColor.withOpacity(0.3),
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                        onTap: () => uploadItemImage(index),
                      ),
                      secondChild: SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        height: MediaQuery.of(context).size.height / 8.7,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: files.values.elementAt(index).isEmpty
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3.4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8.7,
                                    )
                                  : ClipRRect(
                                      borderRadius: Radii.k10pxRadius,
                                      child: Image.file(
                                        File(files.values.elementAt(index)),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8.7,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() =>
                                      files[files.keys.elementAt(index)] = '');
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
                    14.widthInPixel(),
                    Text(camelCase(
                        files.keys.elementAt(index).replaceAll('_', ' ')))
                  ],
                ),
              )),
    );
  }
}
