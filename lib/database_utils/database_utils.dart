import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUtils{


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

}