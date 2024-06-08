import 'dart:io';
import 'package:InvenstAnalys/core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../../bloc/client/client_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late ClientCubit clientCubit;

  File? dosya;
  String boyutlar = "";
  File? cacheDosyasi;

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    profiliVarsaYukle();
  }

  Future<void> profiliVarsaYukle() async {
    try {
      final Directory appCacheDir = await getTemporaryDirectory();
      File f = File("${appCacheDir.path}/avatar.jpg");

      if (f.existsSync()) {
        print("Dosya Bulundu");
        setState(() {
          cacheDosyasi = f;
        });
      } else {
        print("Dosya Bulunmadı");
      }
    } catch (e) {
      print("Error in profiliVarsaYukle: $e");
    }
  }

  Future<void> profilePhotoUptade() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? secilenDosya = await picker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );

      if (secilenDosya == null) {
        setState(() {
          dosya = null;
        });
        return;
      }

      var dosyaFormati = secilenDosya.name.split(".").last.toLowerCase();
      bool kucutebilirmiyim = ["jpg", "jpeg", "bmp", "tiff", "ico", "gif", "png"].contains(dosyaFormati);

      if (!kucutebilirmiyim) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya Boyutu"),
            content: Text("Seçtiğiniz dosya boyutu çok küçük"),
          ),
        );
        return;
      }

      img.Image? temp;
      final bytes = await File(secilenDosya.path).readAsBytes();
      switch (dosyaFormati) {
        case "jpg":
        case "jpeg":
          temp = img.decodeJpg(bytes);
          break;
        case "png":
          temp = img.decodePng(bytes);
          break;
        case "bmp":
          temp = img.decodeBmp(bytes);
          break;
        case "gif":
          temp = img.decodeGif(bytes);
          break;
        case "tiff":
          temp = img.decodeTiff(bytes);
          break;
        case "ico":
          temp = img.decodeIco(bytes);
          break;
      }

      if (temp == null || temp.width < 500 || temp.height < 500) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya Tipi"),
            content: Text("Seçtiğiniz dosya desteklenmiyor"),
          ),
        );
        return;
      }

      img.Image thumbnail = temp.width >= temp.height
          ? img.copyResize(temp, height: 500)
          : img.copyResize(temp, width: 500);

      final resizedDosyaVerileri = img.encodeJpg(thumbnail, quality: 85);
      final Directory tempDir = await getTemporaryDirectory();
      File yeniFile = File("${tempDir.path}/avatar_temp.jpg");

      await yeniFile.writeAsBytes(resizedDosyaVerileri, flush: true);

      setState(() {
        dosya = yeniFile;
        cacheDosyasi = yeniFile;
        boyutlar = "${temp!.width}x${temp.height}";
      });
    } catch (e) {
      print("Error in profilePhotoUptade: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).getTranslate("account"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(10),
              if (cacheDosyasi != null)
                CircleAvatar(
                  backgroundImage: FileImage(cacheDosyasi!),
                  maxRadius: 64,
                )
              else
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRy5QMODyHm-LaMpgXOqMIUHPbQ-Y51jAZR_UJYC-9Dv1IL3ovh"),
                  maxRadius: 64,
                ),
              const Gap(10),
              OutlinedButton(
                onPressed: profilePhotoUptade,
                child: const Text("Profile Photo Update"),
              ),
              const Gap(10),
              if (dosya != null)
                Column(
                  children: [
                    Text("File Size: ${dosya!.lengthSync() / 1000} KB"),
                    Text("Boyutlar: $boyutlar"),
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: FileImage(dosya!),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
