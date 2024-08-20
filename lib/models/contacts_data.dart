import 'package:chat/helpers/networking.dart';

class ContactsData {
  Future<dynamic> getContacts({context}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/getContacs', context: context);
    var decodeData = await networHelper.getData();
    return decodeData;
  }
}
