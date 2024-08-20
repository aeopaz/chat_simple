import 'package:chat/components/button_widget.dart';
import 'package:chat/helpers/pusher_cliente.dart';
import 'package:chat/models/messages_model.dart';
import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  static const id = 'chat';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String newMessage = '';
  bool isLoading = false;
  int idUserLogueado = 0;
  Menssages messages = Menssages();
  MyPusherClient myPusherClient =
      MyPusherClient(channelName: 'client-saludo.2', eventName: 'NewMessage');
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getIdUserLogueado();
  }

  _getIdUserLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUserLogueado = prefs.getInt('idUser')!;
  }

//Bajar scroll del listview
  _scrollBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn);
    });
    _conectPusher() async {
      myPusherClient.onConnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic parameters = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(parameters['name']),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: FutureBuilder(
                future: messages.getMessages(
                    context: context, userId2: parameters['idUser']),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dynamic messages = snapshot.data['messages'];
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        _scrollBottom();
                        return messages[index]['user_id_1'] != idUserLogueado
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 60),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: ListTile(
                                    leading: Text(messages[index]['message']),
                                    trailing: Text(
                                      messages[index]['created_at'],
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    textColor: Colors.black,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 60, right: 20, top: 10, bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ListTile(
                                    trailing: Text(messages[index]['message']),
                                    leading: Text(
                                      messages[index]['created_at'],
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                    textColor: Colors.black,
                                  ),
                                ),
                              );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error');
                  }
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    child: MyProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: kTextFieldDecorationLogin.copyWith(
                      hintText: 'Escriba un mensaje',
                    ),
                    onChanged: (value) async {
                      newMessage = value;
                    },
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  dynamic response = await messages.sendMessage(
                      context: context,
                      message: newMessage,
                      userId2: parameters['idUser']);
                  if (response != null) {
                    _scrollBottom();
                  }
                },
                child: Icon(
                  Icons.send,
                ),
                minWidth: 10.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
