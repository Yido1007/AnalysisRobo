// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../bloc/client/client_cubit.dart';
import '../../core/localizations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String locationResult = "";
  String notificationResult = "";
  controlPer() async {
    var status = await Permission.location.status;
    switch (status) {
      case (PermissionStatus.granted):
        setState(() {
          locationResult = AppLocalizations.of(context).getTranslate("authorized");
        });
        break;
      case (PermissionStatus.denied):
        setState(() {
          locationResult = AppLocalizations.of(context).getTranslate("blocked");
        });
        break;
      case (PermissionStatus.restricted):
        setState(() {
          locationResult = AppLocalizations.of(context).getTranslate("restricted");
        });
        break;
      case PermissionStatus.limited:
        setState(() {
          locationResult = AppLocalizations.of(context).getTranslate("limited");
        });
        break;
      case PermissionStatus.permanentlyDenied:
        setState(() {
          locationResult = AppLocalizations.of(context).getTranslate("completely_rejected");
        });
        break;
      case PermissionStatus.provisional:
        setState(() {
          locationResult = AppLocalizations.of(context).getTranslate("temporary");
        });
        break;
    }
    await Permission.notification.onDeniedCallback(() {
      setState(() {
        locationResult = AppLocalizations.of(context).getTranslate("denied");
      });
      // Your code
    }).onGrantedCallback(() {
      setState(() {
        notificationResult = AppLocalizations.of(context).getTranslate("authorized");
      });
      // Your code
    }).onPermanentlyDeniedCallback(() {
      setState(() {
        notificationResult = "Tamamen Reddedildi";
      });
      // Your code
    }).onRestrictedCallback(() {
      setState(() {
        locationResult = AppLocalizations.of(context).getTranslate("restricted");
      });
      // Your code
    }).onLimitedCallback(() {
      setState(() {
        locationResult = AppLocalizations.of(context).getTranslate("limited");
      });
      // Your code
    }).onProvisionalCallback(() {
      // Your code
      setState(() {
        locationResult = AppLocalizations.of(context).getTranslate("temporary");
      });
    }).request();
  }

  late ClientCubit clientCubit;
  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    controlPer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).getTranslate("notifications"),
          ),
          centerTitle: true,
        ),
        body: SizedBox.expand(
          child: ListView(
            children: [
              ExpansionTile(
                title: Text(
                  AppLocalizations.of(context).getTranslate("location_permissions"),
                ),
                children: [
                  const Gap(15),
                  Text(locationResult),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final status = await Permission.location.request();
                      },
                      child: Text(AppLocalizations.of(context).getTranslate("give_permission")),
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: Text(
                  AppLocalizations.of(context).getTranslate("notification_permissions"),
                ),
                children: [
                  const Gap(15),
                  Text(notificationResult),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final status = await Permission.notification.request();
                      },
                      child: Text(
                        AppLocalizations.of(context).getTranslate("give_permission"),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
