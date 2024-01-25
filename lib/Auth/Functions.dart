import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:MysqlApp/Auth/AuthUtils/snackBar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int? id;
  final String name;
  final String email;
  String? sinceMember;

  User({
    this.id,
    required this.name,
    required this.email,
    this.sinceMember,
  });
}

class UserController extends GetxController {
  final Rx<User?> user = Rx<User?>(null);

  Future<MySqlConnection> connectToDatabase() async {
    final settings = ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'Username',
      password: 'password',
      db: 'database',
    );

    await Future.delayed(const Duration(milliseconds: 100));

    final connection = await MySqlConnection.connect(settings);
    return connection;
  }

  Future<bool> registerUser(String name, String email, String password) async {
    MySqlConnection? conn;
    try {
      conn = await connectToDatabase();

      // Check if the email already exists in the database
      var emailCheckResults = await conn.query(
        'SELECT * FROM users WHERE email = ?',
        [email],
      );

      if (emailCheckResults.isNotEmpty) {
        // Email already exists, don't insert a new record
        showCustomSnackBar(
          "Email already registered. Please log in or use a different email.",
          title: "Registration",
        );
        return false;
      }

      // Email doesn't exist, proceed with registration
      var now = DateTime.now();
      var formattedDate = DateFormat('yyyy-MM-dd').format(now);

      var insertResult = await conn.query(
        'INSERT INTO users (Name, Email, Password, since_member) VALUES (?, ?, ?, ?)',
        [name, email, password, formattedDate],
      );

      if (insertResult.affectedRows == 0) {
        return false;
      }

      var userId = insertResult.insertId;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', userId.toString());
      prefs.setString('Name', name);
      prefs.setString('Email', email);

      user.value = User(
        id: userId,
        name: name,
        email: email,
        sinceMember: formattedDate,
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting user data: $e');
      }
      return false;
    } finally {
      await conn?.close();
    }
  }

  Future<bool> login(String email, String password) async {
    MySqlConnection? conn;
    try {
      conn = await connectToDatabase();

      var results = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [email, password],
      );

      if (results.isEmpty) {
        showCustomSnackBar(
          "Incorrect email or password",
          title: "Log In",
        );
        return false;
      }

      var userData = results.first;
      var userId = userData['id'] as int;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', userId.toString());
      prefs.setString('Name', userData['Name']);
      prefs.setString('Email', userData['Email']);
      String sinceMemberString = userData['since_member']?.toString() ?? '';
      prefs.setString('since_member', sinceMemberString);

      user.value = User(
        id: userId,
        name: userData['Name'],
        email: userData['Email'],
        sinceMember: sinceMemberString,
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error logging in: $e');
      }
      return false;
    } finally {
      await conn?.close();
    }
  }

  void logOut() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('Name');
      prefs.remove('Email');
      prefs.remove('sinceMember');
    });

    user.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      final idString = prefs.getString('id');
      final name = prefs.getString('Name');
      final email = prefs.getString('Email');
      final sinceMember = prefs.getString('since_member') ?? '';

      if (idString != null && name != null && email != null) {
        final id = int.tryParse(idString);

        if (id != null) {
          user.value = User(
            id: id,
            name: name,
            email: email,
            sinceMember: sinceMember,
          );
        }
      }
    });
  }
}
