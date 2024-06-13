import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_mobile/provider/contact_provider.dart';
import 'package:test_flutter_mobile/screen/contact_details_page.dart';
import 'package:test_flutter_mobile/screen/new_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ContactProvider contactProvider;
  late ThemeData themeData;
  TabController? _tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ContactProvider>(context, listen: false).getContacts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    contactProvider = Provider.of<ContactProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('My Contacts', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewContactPage()));
        },
        tooltip: 'Add new contact',
        child: const Icon(Icons.add),
      ), // T
      body: DefaultTabController(
          length: 2,
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: GridView.count(
                  padding: EdgeInsets.all(0),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children:
                      List.generate(contactProvider.contacts.length, (index) {
                    return Center(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ContactDetailsPage(index: index)));
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: themeData.colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(18, 0, 0, 0),
                              blurRadius: 3,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${contactProvider.contacts[index].firstName?.substring(0, 1) ?? ''}${contactProvider.contacts[index].lastName?.substring(0, 1) ?? ''}',
                                    style: TextStyle(
                                        color: themeData.colorScheme.onPrimary),
                                  ))),
                            ),
                            Text(
                                '${contactProvider.contacts[index].firstName} ${contactProvider.contacts[index].lastName}')
                          ]),
                        ),
                      ),
                    ));
                  }),
                ),
              ),
              Container(),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '',
            ),
          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabController?.index = index;
    });
  }
}
