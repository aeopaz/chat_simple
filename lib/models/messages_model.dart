import 'package:chat/helpers/networking.dart';

class Menssages {
  Future<dynamic> sendMessage({context, userId2, message}) async {
    Map<String, String> body = {
      'user_id_2': userId2.toString(),
      'message': message
    };

    NetworHelper networHelper =
        NetworHelper(url: '/message/store', context: context, body: body);
    var decodeData = await networHelper.postData();

    return decodeData;
  }

  Future<dynamic> getMessages({context, userId2}) async {
    Map<String, String> body = {
      'user_id_2': userId2.toString(),
    };
    NetworHelper networHelper =
        NetworHelper(url: '/message/index', context: context, body: body);

    var decodeData = await networHelper.postData();
    return decodeData;
  }
}
