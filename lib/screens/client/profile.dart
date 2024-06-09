// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print, sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../../core/localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? file;
  File? coverPhoto;
  String size = "";
  MemoryImage? currentAvatar;
  String? currentCoverPhoto;

  profileIfYouLoad() async {
    final Directory appCacheDir = await getApplicationCacheDirectory();
    final avatarDir = Directory("${appCacheDir.path}/avatar");
    if (avatarDir.existsSync()) {
      final files = avatarDir.listSync();
      if (files.isNotEmpty) {
        File f = File(files.first.path);
        var bytes = f.readAsBytesSync();
        setState(() {
          currentAvatar = MemoryImage(bytes);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    profileIfYouLoad();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(), body: profileMenu(context)),
    );
  }

  Future<void> profilePhotoUpdate() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? selectedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (selectedFile == null) {
        setState(() {
          file = null;
        });
        return;
      }

      var fileFormat = selectedFile.name.split(".").last;

      bool makeSmall = false;

      switch (fileFormat.toLowerCase()) {
        case ("jpg"):
        case ("jpeg"):
        case ("png"):
        case ("bmp"):
        case ("tiff"):
        case ("ico"):
        case ("gif"):
          makeSmall = true;
      }

      if (!makeSmall) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya Türü"),
            content: Text(
              "Seçtiğiniz dosya, dosya türünü desteklemiyor!!",
            ),
          ),
        );
        return;
      }

      img.Image? temp;
      if (fileFormat.toLowerCase() == "jpg" || fileFormat.toLowerCase() == "jpeg") {
        temp = img.decodeJpg(File(selectedFile.path).readAsBytesSync());
      } else if (fileFormat.toLowerCase() == "png") {
        temp = img.decodePng(File(selectedFile.path).readAsBytesSync());
      } else if (fileFormat.toLowerCase() == "bmp") {
        temp = img.decodeBmp(File(selectedFile.path).readAsBytesSync());
      } else if (fileFormat.toLowerCase() == "tiff") {
        temp = img.decodeTiff(File(selectedFile.path).readAsBytesSync());
      } else if (fileFormat.toLowerCase() == "ico") {
        temp = img.decodeIco(File(selectedFile.path).readAsBytesSync());
      } else if (fileFormat.toLowerCase() == "gif") {
        temp = img.decodeGif(File(selectedFile.path).readAsBytesSync());
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya Formati"),
            content: Text(
              "Dosya Formati JPG, BMP, GIF, PNG, TIFF olabilir.",
            ),
          ),
        );
        return;
      }

      if (temp!.width < 500 || temp.height < 500) {
        await showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya Boyutu"),
            content: Text(
              "Seçtiğiniz dosya boyutları çok küçük. En az 500px yükseklik ve genişlik gerekmektedir.",
            ),
          ),
        );
        return;
      }

      img.Image thumbnail;
      if (temp.width >= temp.height) {
        thumbnail = img.copyResize(temp, width: 500);
      } else {
        thumbnail = img.copyResize(temp, height: 500);
      }

      final resizedFileData = img.encodeJpg(thumbnail, quality: 85);

      final Directory appCacheDir = await getApplicationCacheDirectory();

      final avatarDir = Directory("${appCacheDir.path}/avatar");
      if (avatarDir.existsSync()) {
        final files = avatarDir.listSync();
        if (files.isNotEmpty) {
          for (var element in files) {
            File(element.path).deleteSync();
          }
        }
      } else {
        avatarDir.createSync();
      }

      File newFile = File("${appCacheDir.path}/avatar/avatar.${fileFormat.toLowerCase()}");
      newFile.writeAsBytesSync(resizedFileData);

      setState(() {
        file = newFile;
        currentAvatar = MemoryImage(resizedFileData);
        size = "${temp!.width}x${temp.height}";
      });
    } catch (e) {
      print("Hata Oluştu: $e");
    }
  }

  void deleteProfilePhoto() async {
    final Directory appCacheDir = await getApplicationCacheDirectory();

    final avatarDir = Directory("${appCacheDir.path}/avatar");
    if (avatarDir.existsSync()) {
      final files = avatarDir.listSync();
      if (files.isNotEmpty) {
        for (var element in files) {
          File(element.path).deleteSync();
        }
      }
    }

    setState(() {
      file = null;
      currentAvatar = null;
      size = ""; // Reset the size variable
    });
  }

  Column profileMenu(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 230,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: currentCoverPhoto != null
                    ? Image.file(
                        File(currentCoverPhoto!),
                        width: double.infinity,
                        height: 300, // Sabit yükseklik
                        fit: BoxFit.cover,
                      )
                    : Container(
                        // color: Colors.grey, // Arka plan rengi
                        width: double.infinity,
                        height: 300, // Sabit yükseklik
                      ),
              ),
              Center(
                child: Positioned(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: currentAvatar,
                    child: currentAvatar == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await profilePhotoUpdate();
              },
              child: Text(AppLocalizations.of(context).getTranslate("update_profile")),
            ),
            const Gap(10),
            Tooltip(
              message: AppLocalizations.of(context).getTranslate("delete_profile"),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  deleteProfilePhoto();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
