import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_mobile/model/contact.dart';
import 'package:test_flutter_mobile/provider/contact_provider.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  late ThemeData themeData;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Details')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Icon(Icons.people, color: Colors.white,))),
              Text(
                'Main Information',
                style: TextStyle(
                    color: themeData.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Divider(color: themeData.colorScheme.secondary),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('First Name'),
                      TextFormField(
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Last name'),
                      TextFormField(
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sub Information',
                style: TextStyle(
                    color: themeData.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Divider(color: themeData.colorScheme.secondary),
              const Text('Email'),
              TextFormField(
                validator: (value) {
                  String patttern =
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                  RegExp regExp = RegExp(patttern);
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  if (!regExp.hasMatch(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
                controller: _emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Phone Number'),
              TextFormField(
                controller: _phoneNumberController,
                validator: (value) {
                  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                  RegExp regExp = RegExp(patttern);
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  if (!regExp.hasMatch(value)) {
                    return 'Please enter valid mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    print('pressed');
                    if (_formKey.currentState!.validate()) {
                      Provider.of<ContactProvider>(context, listen: false)
                          .addContact(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              _phoneNumberController.text);
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully Added')),
                      );
                    }
                  },
                  child: Text('Save',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
