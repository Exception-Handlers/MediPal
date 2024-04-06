import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? imageFile;
  double uploadProgress = 0;
  String? uploadStatus;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path); // Store the actual picked image path
      });
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;

    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef.child("images/${DateTime.now()}.jpg").putFile(imageFile!, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      setState(() {
        uploadProgress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        uploadStatus = taskSnapshot.state == TaskState.running ? "Uploading..." : "Upload complete";
      });

      if (taskSnapshot.state == TaskState.success) {
        // Handle successful upload (e.g., navigate to next form)
        print("Upload successful!");
        // You can potentially navigate to the next form here
      } else if (taskSnapshot.state == TaskState.error) {
        // Handle unsuccessful upload
        print("Upload failed!");
        // Display error message to the user
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Form'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imageFile != null)
              Image.file(imageFile!, height: 200, width: 200),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text('Upload Image'),
            ),
            if (uploadStatus != null)
              Text(
                uploadStatus!,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
