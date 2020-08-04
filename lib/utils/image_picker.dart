import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<File> pickImage(ImageSource source);
  Future<File> pickVideo(ImageSource source);
  // video
  // audio
}

class ImagePickerServiceInstance extends ImagePickerService {
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
