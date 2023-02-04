import 'package:chat/database_utils/database_utils.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/models/room_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderId: myUser.id,
        senderName: myUser.name,
        roomId: room.id);
    DataBaseUtils.addMessageToFirestore(message).then((value) {
      navigator!.clearMessage();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }

  Stream<QuerySnapshot<Message>> getMessages() {
    return DataBaseUtils.readMessagesFromFirestore(room.id);
  }
}