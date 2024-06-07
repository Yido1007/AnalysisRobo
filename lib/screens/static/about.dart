import 'package:InvenstAnalys/core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../bloc/client/client_cubit.dart';
import '../core/cache.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Map<String, dynamic> pageConfig = {};
  bool configLoader = false;
  loadData() async {
    CacheSystem cs = CacheSystem();
    final pageConfig = await cs.aboutConfig();
    setState(() {
      this.pageConfig = pageConfig;
      configLoader = true;
    });
  }

  late ClientCubit clientCubit;
  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).getTranslate("about")),
          centerTitle: true,
        ),
        body: !configLoader
            ? const SizedBox()
            : SizedBox.expand(
                child: ListView(
                  children: [
                    const Gap(25),
                    Column(
                      children: [
                        if (pageConfig["cover"].isNotEmpty)
                          ClipRRect(
                              child: Image.asset(
                            pageConfig["cover"],
                            cacheWidth: 250,
                          )),
                        if (pageConfig["title"].isNotEmpty)
                          Text(
                            pageConfig["title"],
                            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
                          ),
                        const Gap(10),
                        if (pageConfig["subtitle"].isNotEmpty)
                          Text(
                            pageConfig["subtitle"],
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        const Gap(10),
                        if (pageConfig["text"].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              pageConfig["text"],
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
