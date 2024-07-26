import 'dart:ffi';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

/// This function saves a file to the local file system and opens it.
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  try {
    // Get the path to the application's documents directory
    //final directory = await getApplicationDocumentsDirectory();
    if (await requestPermissions()) {
      final path = '/storage/self/primary/Download/Cash_Book/${fileName}';

      // Create a file reference with the provided path
      final file = File(path);

      // Write the bytes to the file
      await file.writeAsBytes(bytes);

      // Open the file
      final result = await OpenFile.open(path);

      if (result.type != ResultType.done) {
        print('Error opening file: ${result.message}');
      } else {
        print("File opened successfully");
      }
    } else {
      print('Error ');
    }
  } catch (e) {
    print('Error saving or opening file: $e');
  }
}

// Request permissions
Future<bool> requestPermissions() async {
  final status = await Permission.storage.request();
  bool success = false;
  if (status.isGranted) {
    // Permission granted
    print('Storage permission granted');
    return success = true;
  } else {
    // Permission denied
    print('Storage permission denied');
    return success;
  }
}
