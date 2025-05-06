import 'package:flutter/material.dart';
import 'package:tramber/View/modules/admin/admin_login.dart';
import 'package:tramber/View/modules/user/login/login.dart';

class AdminOrUserPage extends StatelessWidget {
  const AdminOrUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
          height: hight,
          width: width,
          child: Center(
            child: SizedBox(
              height: hight / 2,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: SizedBox(
                      width: width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginAdmin()));
                          },
                          child: const Text(
                            "Admin",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )),
                    ),
                  ),
                  const Text("OR"),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SizedBox(
                      width: width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()));
                          },
                          child: const Text("User",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
