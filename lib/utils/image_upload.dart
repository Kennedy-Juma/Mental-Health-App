import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    final String filename = _file.name;
    final Uint8List imageBytes = await _file.readAsBytes();
    return {'imageBytes': imageBytes, 'filename': filename};
  }
  print('No Images Selected');
  return null;
}
