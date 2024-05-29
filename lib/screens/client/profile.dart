import 'dart:io';
import 'package:analysisrobo/core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/client/client_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
late ClientCubit clientCubit;

  File? dosya;

  profilePhotoUptade()async {

    try{
      ImagePicker picker = ImagePicker();
     XFile? secilenDosya = await picker.pickImage(source: ImageSource.gallery);
    if(secilenDosya == null){
      setState(() {
        dosya = null;
      }); 
      return;
    }

    setState(() {
      dosya = File(secilenDosya.path);
    });
     
    
    } on Exception catch(e) { 
      print("Error" );
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
                backgroundImage: NetworkImage("https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRy5QMODyHm-LaMpgXOqMIUHPbQ-Y51jAZR_UJYC-9Dv1IL3ovh"),
                maxRadius: 64,
              ),
              const Gap(10),
              OutlinedButton(onPressed:  profilePhotoUptade , 
              child: const Text("Profile Photo Update "), 
              ),
              const Gap(10),
              if(dosya !=null) Image.file(dosya!),
            ],
          ),
        ),
      ),
    );
  }
}
