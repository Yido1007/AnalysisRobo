import 'dart:io';
import 'package:InvenstAnalys/core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
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


  profilePhotoUptade() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? secilenDosya = await picker.pickImage(source: ImageSource.gallery,requestFullMetadata: false);
      
      if (secilenDosya == null) {
        setState(() {
          dosya = null;
        });
        return;
      }
      var fileLength = await secilenDosya.length();

    
   var dosyaFormati = secilenDosya.name.split(".").last;
//profilim.JPG
    bool kucutebilirmiyim = false;
    
    switch(dosyaFormati.toLowerCase()) {
      case ("jpg"):
      case ("jpeg"):
      case ("bmp"):
      case ("tiff"):
      case ("ico"):
      case ("gif"):
      case ("png"):
      kucutebilirmiyim = true;
    
    }
    
    if(!kucutebilirmiyim){
 showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Dosya Boyutu"),content: Text("Sectiginiz dosya boyutu cok kucuk"),));
    }  
    img.Image?   temp;
    if(dosyaFormati.toLowerCase() == "jpg" || dosyaFormati.toLowerCase() == "jpeg"){
          temp = img.decodeJpg(File(secilenDosya.path).readAsBytesSync());

    }

    else if (dosyaFormati.toLowerCase() ==  "png" ) {
      temp = img.decodePng(File(secilenDosya.path).readAsBytesSync());
    }
    else if (dosyaFormati.toLowerCase() ==  "bmp" ) {
      temp = img.decodeBmp(File(secilenDosya.path).readAsBytesSync());
    }
    else if (dosyaFormati.toLowerCase() ==  "gif" ) {
      temp = img.decodeGif(File(secilenDosya.path).readAsBytesSync());
    }
    else if (dosyaFormati.toLowerCase() ==  "tiff" ) {
      temp = img.decodeTiff(File(secilenDosya.path).readAsBytesSync());
    }
    else if (dosyaFormati.toLowerCase() ==  "ico" ) {
      temp = img.decodeIco(File(secilenDosya.path).readAsBytesSync());
    }
    
  
     if(temp!.width <500 || temp.height <500 || temp == null ){
      showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Dosya Tipi"),content: Text("Sectiginiz dosya desteklenmiyor"),));
        return;
   
   } 
    //resize 

     // Read a jpeg image from file.
  
  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  // ignore: dead_code
  img.Image thumbnail = img.copyResize(temp, width: 500);
  // Save the thumbnail to a jpeg file.
  final resizedDosyaVerileri =  img.encodeJpg(thumbnail,quality: 85);





 //    final yeniDosyam = File.fromRawPath(resizedDosyaVerileri);
      
    File yeniFile = File(secilenDosya.path + "resized.jpg" );

    yeniFile.writeAsBytesSync(resizedDosyaVerileri);
   // img.Image?   temp2 = img.decodeJpg(yeniDosyam.readAsBytesSync());


  //  print ("yeni dosya boyutları: ${temp2!.width}x${temp2!.height} ");


      
      setState(() {
        dosya = yeniFile; 
        boyutlar = "${temp!.width}x${temp!.height}";
      });

      




      
    } on Exception catch (e) {
      print("Error");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
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
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRy5QMODyHm-LaMpgXOqMIUHPbQ-Y51jAZR_UJYC-9Dv1IL3ovh"),
                maxRadius: 64,
              ),
              const Gap(10),
              OutlinedButton(
                onPressed: profilePhotoUptade,
                child: const Text("Profile Photo Update "),
              ),
              const Gap(10),
              if (dosya != null) Column(
                children: [
                  Text("File Size: ${dosya!.lengthSync()/1000} KB"),
                  Text("Boyutlar: $boyutlar"),
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: FileImage(
                      dosya!,
                    ),
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
