import 'package:flutter/material.dart';

abstract class BaseNavigator{

  void showLoading({String message});
  void showMessage(String message);
  void hideLoading();
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier{
  Nav? navigator = null;
}

abstract class BaseView<T extends StatefulWidget , VM extends BaseViewModel>
extends State<T> implements BaseNavigator{

  late VM viewModel;

  VM initViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading({String message = '  Loading..'}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Row(
              children: [const CircularProgressIndicator(), Text(message)],
            )),
      ),
    );
  }

  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text(" Alert !"),
            content: Text(message),
          ),
    );
  }
}