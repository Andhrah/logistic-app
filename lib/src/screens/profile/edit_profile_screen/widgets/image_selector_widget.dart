import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';

class EditProfileImageSelectorWidget extends StatefulWidget {
  final Function(File? itemImage) callback;

  const EditProfileImageSelectorWidget(this.callback, {Key? key})
      : super(key: key);

  @override
  _EditProfileImageSelectorWidgetState createState() =>
      _EditProfileImageSelectorWidgetState();
}

class _EditProfileImageSelectorWidgetState
    extends State<EditProfileImageSelectorWidget> {
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

  doCallback() => widget.callback(file);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      children: [
        Hero(
          tag: 'profile_pic',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.black12.withAlpha(30),
              borderRadius: Radii.k50pxRadius,
              onTap: uploadItemImage,
              child: Stack(
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: file == null
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: ClipOval(
                      child: StreamBuilder<AppSettings>(
                          stream: appSettingsBloc.appSettings,
                          builder: (context, snapshot) {
                            String avatar = '';

                            if (snapshot.hasData) {
                              avatar = snapshot.data?.loginResponse?.data?.user
                                      ?.avatar ??
                                  '';
                            }
                            return CachedNetworkImage(
                              imageUrl: avatar,
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    color: appPrimaryColor.withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.person,
                                  color: secondaryColor,
                                  size: 40,
                                ),
                              ),
                              errorWidget: (context, url, err) => Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    color: appPrimaryColor.withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.person,
                                  color: secondaryColor,
                                  size: 40,
                                ),
                              ),
                            );
                          }),
                    ),
                    secondChild: ClipOval(
                      child: file == null
                          ? const SizedBox(
                              width: 110,
                              height: 110,
                            )
                          : Image.file(
                              file!,
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black38),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        if (file != null)
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Button(
                onPress: () {
                  setState(() => file = null);
                  doCallback();
                },
                text: 'Remove',
                fontSize: 8,
                color: Colors.grey,
                width: 100,
                height: 35,
                borderRadius: 8,
                textColor: Colors.black,
                isLoading: false),
          )
      ],
    );
  }
}
