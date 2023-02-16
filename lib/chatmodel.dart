enum chatMsgType { user, bot }

class ChatMsg {
  ChatMsg({required this.text, required this.chat});
  String? text;
  chatMsgType? chat;
}
