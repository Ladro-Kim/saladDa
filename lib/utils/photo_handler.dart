import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salad_da/widgets/widget_select_photo.dart';

Future<File> getPhotoFromGallery() async {
  var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    var croppedImage = await ImageCropper.cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        backgroundColor: Colors.white,
        toolbarTitle: "Cropper",
        toolbarColor: Colors.green,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
        showCropGrid: true,
      ),
      iosUiSettings: IOSUiSettings(
        title: "Cropper",
        cancelButtonTitle: "Cancel",
        doneButtonTitle: "Done",
        aspectRatioPickerButtonHidden: true,
        aspectRatioLockEnabled: true,
      )
    );
    if (croppedImage != null) {
      return croppedImage;
    }
  }
  return null;
}
