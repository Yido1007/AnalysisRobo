import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  Future<bool> isFirstLaunch() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    final runned = storage.getBool("runned");

    var counter = storage.getInt("launchCount");

    if (runned == null) {
      counter = 1;
      await storage.setInt("launchCount", 1);
      return true;
    } else {
      await storage.setInt("launchCount", counter! + 1);
      return false;
    }
  }

  firstLauched() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    await storage.setBool("runned", true);
  }

  clearStorage() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }

  loadUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var id = storage.getInt("id");
    var name = storage.getString("name");
    var phone = storage.getString("phone");
    var email = storage.getString("email");

    if (id == null) {
      return null;
    } else {
      return {"id": id, "name": name, "phone": phone, "email": email};
    }
  }

  saveUser(
      {required int id,
      required String name,
      required String email,
      required String phone}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt("id", id);
    storage.setString("name", name);
    storage.setString("email", email);
    storage.setString("phone", phone);
  }

  saveToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "token", value: token);
  }

  readToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "token", value: token);
  }

  loadToken() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    return token;
  }

  clearUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final securestorage = new FlutterSecureStorage();
    storage.remove("id");
    storage.remove("name");
    storage.remove("phone");
    storage.remove("email");

    securestorage.delete(key: "token");
  }
}
