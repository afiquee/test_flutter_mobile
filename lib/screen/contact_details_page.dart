import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_mobile/model/contact.dart';
import 'package:test_flutter_mobile/provider/contact_provider.dart';

class ContactDetailsPage extends StatefulWidget {
  final int? index;
  const ContactDetailsPage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late ThemeData themeData;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  late ContactProvider contactProvider;
  String initials = '';

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Contact contact = Provider.of<ContactProvider>(context, listen: false)
          .getContact(widget.index!);
      setState(() {
        initials =
            '${contact.firstName?.substring(0, 1) ?? ''}${contact.lastName?.substring(0, 1) ?? ''}';
        print('initials $initials');
      });

      _firstNameController.text = contact.firstName ?? '';
      _lastNameController.text = contact.lastName ?? '';
      _emailController.text = contact.email ?? '';
      _phoneNumberController.text = contact.phoneNumber ?? '';
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    contactProvider = Provider.of<ContactProvider>(context, listen: true);
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
                      child: Text(
                    initials,
                    style: TextStyle(color: themeData.colorScheme.onPrimary),
                  ))),
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
                          .updateContact(
                              widget.index!,
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              _phoneNumberController.text);
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      setState(() {
                        Contact contact =
                            Provider.of<ContactProvider>(context, listen: false)
                                .getContact(widget.index!);
                        setState(() {
                          initials =
                              '${contact.firstName?.substring(0, 1) ?? ''}${contact.lastName?.substring(0, 1) ?? ''}';
                        });
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully Updated')),
                      );
                    }
                  },
                  child: Text('Update',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        40), // fromHeight use double.infinity as width and 40 is the height

                    side: BorderSide(
                        width: 1.0, color: themeData.colorScheme.error),
                  ),
                  onPressed: () {
                    Provider.of<ContactProvider>(context, listen: false)
                        .deleteContact(
                      widget.index!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully Deleted')),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Remove',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeData.colorScheme.error)))
            ]),
          ),
        ),
      ),
    );
  }
}
