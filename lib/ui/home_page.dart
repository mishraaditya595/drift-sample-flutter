import 'dart:math';

import 'package:drift_new/data/local_database/app_database.dart';
import 'package:flutter/material.dart';

import '../data/local_database/repository/user_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Button Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  UserDao userDao = AppDatabase.getInstance().userDao;
                  Random random = new Random();
                  int randomNum = random.nextInt(1000);
                  await userDao.insertUser(UserData(id: randomNum, username: "username", musicStyle: "musicStyle", favoriteSongName: "favoriteSongName"));
                  List l = await userDao.getAllUsers();
                  print("user lsit: ${l.length}");

                },
                child: Text('Add'),
              ),
              SizedBox(height: 20), // Spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Remove button action
                },
                child: Text('Remove'),
              ),
              SizedBox(height: 20), // Spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Edit button action
                },
                child: Text('Edit'),
              ),
              SizedBox(height: 20), // Spacing between buttons
              ElevatedButton(
                onPressed: () async {
                  // UserRepository userRepo = UserRepository();
                  // userRepo.getAllUsers();
                  // print("User length: ${l.length}");
                  },
                child: Text('Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}