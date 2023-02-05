import 'package:chat/models/message_model.dart';
import 'package:chat/models/room_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUtils{

///////////////////////////////////////////////////////////
//todo: Users
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  //todo: add user to database
  static Future<void> addUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  //todo: read user to database
  static Future<MyUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> docSnapShot =
    await getUsersCollection().doc(id).get();
    var myUser = docSnapShot.data();
    return myUser;
  }

  ///////////////////////////////////////////////////////////
  //todo: Rooms
  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
      fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
      toFirestore: (room, options) => room.toJson(),
    );
  }
  //todo: add room to database
  static Future<void> AddRoomToFirestore(Room room) {
    var docRef = getRoomsCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRoomsFromFirestore() {
    return getRoomsCollection().snapshots();
  }
///////////////////////////////////////////////////////////
//todo: Messages

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
      fromFirestore: (snapshot, options) =>
          Message.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<void> addMessageToFirestore(Message message) {
    var docRef = getMessageCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessagesFromFirestore(
      String roomId) {
    return getMessageCollection(roomId).orderBy("dateTime").snapshots();
  }
}