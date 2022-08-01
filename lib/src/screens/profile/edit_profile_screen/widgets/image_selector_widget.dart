import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/general_widget.dart';

class EditProfileImageSelectorWidget extends StatefulWidget {
  final Function(File? itemImage) callback;

  final MainAxisAlignment rowMainAxisAlignment;
  final double width;
  final double height;
  final String? avatarURL;

  const EditProfileImageSelectorWidget(this.callback,
      {Key? key,
      this.height = 110,
      this.width = 110,
      this.rowMainAxisAlignment = MainAxisAlignment.start,
      this.avatarURL})
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

  final ImagePicker _picker = ImagePicker();

  uploadItemImage() async {
    modalImageSelector((index) async {
      switch (index) {
        case 0:
          var result = await _picker.pickImage(source: ImageSource.camera);

          if (result != null && result.path.isNotEmpty) {
            setState(() {
              file = File(result.path);
            });

            doCallback();
          }

          break;
        case 1:
          var result = await _picker.pickImage(source: ImageSource.gallery);

          if (result != null && result.path.isNotEmpty) {
            setState(() {
              file = File(result.path);
            });

            doCallback();
          }

          break;
      }
    });
  }

  doCallback() => widget.callback(file);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      mainAxisAlignment: widget.rowMainAxisAlignment,
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

                            if (widget.avatarURL == null && snapshot.hasData) {
                              avatar = snapshot.data?.loginResponse?.data?.user
                                      ?.avatar ??
                                  '';
                            } else {
                              avatar = widget.avatarURL ?? '';
                            }
                            return CachedNetworkImage(
                              imageUrl: avatar,
                              width: widget.width,
                              height: widget.height,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: widget.width,
                                height: widget.height,
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
                                width: widget.width,
                                height: widget.height,
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
                          ? SizedBox(
                              width: widget.width,
                              height: widget.height,
                            )
                          : Image.file(
                              file!,
                              width: widget.width,
                              height: widget.height,
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
