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

  static Future<List<Room>> getRoomsFromFirestore() async {
    QuerySnapshot<Room> snapRoom = await getRoomsCollection().get();
    return snapRoom.docs.map((e) => e.data()).toList();
  }
///////////////////////////////////////////////////////////
//todo: Messages
}