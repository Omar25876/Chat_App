import 'package:chat/database_utils/database_utils.dart';
import 'package:chat/models/room_model.dart';
import 'package:chat/ui/screens/add_room/add_room_navigator.dart';
import 'package:chat/ui/screens/base.dart';


class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {

  void CreateRoom(String roomName, String roomDescription, String catId) {
    Room room = Room(
        roomName: roomName, roomDescription: roomDescription, catId: catId);
    DataBaseUtils.AddRoomToFirestore(room).then((value) {
      navigator!.roomCreated();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }

}