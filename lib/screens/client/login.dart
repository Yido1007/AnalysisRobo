// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/api.dart';
import '../../core/storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  var emailContorller = TextEditingController();
  var passwordController = TextEditingController();

  login() async {
    setState(() {
      loading = true;
    });

    API api = API();
    final response = await api.login(
      username: emailContorller.text,
      password: passwordController.text,
    );

    if (response is Exception) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Girilen Bilgiler Hatalı",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    } else {
      Storage storage = Storage();
      await storage.saveUser(
          id: response["data"]["user"]["id"],
          name: response["data"]["user"]["name"],
          email: response["data"]["user"]["email"],
          phone: response["data"]["user"]["phone_number"]);
      await storage.saveToken(response["data"]["token"]);
      Navigator.of(context).pushReplacementNamed("/home");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giriş",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: loading
          ? LinearProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "E-posta",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(61, 158, 158, 158),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: emailContorller,
                      decoration: InputDecoration(
                        hintText: "E-posta...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Şifre",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(61, 158, 158, 158),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Şifre...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: login,
                        child: Text("Giriş yap"),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hesap oluşturmak için tıklayınız"),
                      Icon(Icons.arrow_right_alt_outlined),
                      Gap(30),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/register"),
                        child: Text("Kayıt ol"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
