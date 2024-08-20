import 'package:chat/components/button_widget.dart';
import 'package:chat/components/nav_drawer.dart';
import 'package:chat/helpers/notifications.dart';
import 'package:chat/helpers/pusher_cliente.dart';
import 'package:chat/models/contacts_data.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});
  static const id = 'contacts';
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactsData contactsData = ContactsData();
  MyPusherClient myPusherClient =
      MyPusherClient(channelName: 'private-saludo.2', eventName: 'NewMessage');
  User user = User();
  @override
  void initState() {
    super.initState();
    _loadToken();
    _loadNotifications();
    _conectPusher();
  }

  _loadToken() async {
    dynamic userData = await user.getUserData(context: context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userData['user']['email']);
    prefs.setString('name', userData['user']['name']);
    prefs.setInt('idUser', userData['user']['id']);
  }

  _loadNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Aquí inicializamos la instancia de notificaciones
    await initNotifications();
  }

  _conectPusher() async {
    myPusherClient.onConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contactos'),
        ),
        drawer: NavDrawer(),
        body: Center(
          child: FutureBuilder(
            future: contactsData.getContacts(context: context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dynamic contacts = snapshot.data['contacts'];
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black38),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.face),
                        title: Text(contacts[index]['name']),
                        onTap: () {
                          Navigator.pushNamed(context, ChatPage.id, arguments: {
                            'name': contacts[index]['name'],
                            'idUser': contacts[index]['id']
                          });
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              }
              return MyProgressIndicator();
            },
          ),
        ));
  }
}
