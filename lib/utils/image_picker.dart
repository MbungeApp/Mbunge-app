import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePickerService _imagePickerService =
      ImagePickerService._internal();

  factory ImagePickerService() {
    return _imagePickerService;
  }

  ImagePickerService._internal();

  pickImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(
      source: source,
    );
    return image;
  }

  pickVideo(ImageSource source) async {
    File video = await ImagePicker.pickVideo(
      source: source,
    );
    return video;
  }
}
