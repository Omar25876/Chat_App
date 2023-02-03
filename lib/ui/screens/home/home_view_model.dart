import 'package:chat/database_utils/database_utils.dart';
import 'package:chat/models/room_model.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/home/home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void getRooms() {
    DataBaseUtils.getRoomsFromFirestore().then((value) {
      rooms = value;
    });
  }
}
