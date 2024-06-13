import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ThemeData themeData;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Hi There',
            style: TextStyle(
                color: themeData.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          const Text(
            'Please login to see your contact list',
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Username'),
                    TextFormField(
                      controller: _usernameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Password'),
                    TextFormField(
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(
                              40), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        onPressed: () {},
                        child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold)))
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
