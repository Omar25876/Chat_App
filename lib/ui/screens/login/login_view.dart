
import 'package:chat/models/user_model.dart';
import 'package:chat/providers/provider.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/home/home_view.dart';
import 'package:chat/ui/screens/login/login_navigator.dart';
import 'package:chat/ui/screens/login/login_view_model.dart';
import 'package:chat/ui/screens/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static String routeName = 'Login View';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseView<LoginView, LoginViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visable = false;
  var  email =TextEditingController();
  var  password =TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }
  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/bg.png'),fit: BoxFit.fill),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Login',style: TextStyle(
            color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
          elevation: 0.0,

        ),
        body: Form(
          key: formkey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                TextFormField(
                  validator: (text){
                    if(text!.trim() == ''){
                      return "Please Enter Email";
                    }
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if(!emailValid){
                      return "Please Enter Correct Email";
                    }
                    return null;
                  },
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Color.fromRGBO(36, 39, 43, 1.0),
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Please enter e-mail',
                    hintStyle: TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 16,fontWeight: FontWeight.normal),
                    suffixIcon: ImageIcon(AssetImage('assets/Iconfettle.png',),color: Theme.of(context).colorScheme.primary,size: 26, ),
                    focusColor: Colors.cyan,
                    border: UnderlineInputBorder(borderSide: BorderSide(
                      color: Colors.cyan,
                    )),
                    labelText: 'Email',
                    labelStyle:  TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                        fontSize: 16,fontWeight: FontWeight.normal),
                  ),
                ),

                SizedBox(height: 20,),

                TextFormField(
                  controller: password,
                  validator: (text){
                    if(text!.trim() == ''){
                      return "Please Enter Password";
                    }
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: visable == true? false:true,
                  style: TextStyle(
                    color: Color.fromRGBO(36, 39, 43, 1.0),
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Please enter password',
                    hintStyle: TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                        fontSize: 16,fontWeight: FontWeight.normal),
                    suffixIcon: IconButton(
                      onPressed:(){
                        setState(() {
                          if(visable = true){
                            visable = false;
                          }
                          else{
                            visable = true;
                          }
                        });
                      },
                      icon: visable == true? ImageIcon(AssetImage('assets/view.png'), color: Theme.of(context).colorScheme.primary, size: 26,)
                          :Icon(Icons.visibility_off_outlined,color:Theme.of(context).colorScheme.primary,size: 26,)
                    ),
                    focusColor: Colors.cyan,
                    border: UnderlineInputBorder(borderSide: BorderSide(
                      color: Colors.cyan,
                    )),
                    labelText: 'Password',
                    labelStyle:  TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                        fontSize: 16,fontWeight: FontWeight.normal),
                  ),
                ),

                SizedBox(height: 32,),

                Text('Forget Email Or Password ?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(121, 121, 121, 1.0),
                ),),
                SizedBox(height: 32,),

                ElevatedButton(onPressed: (){
                  ValidateForm();
                },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text('Login',textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),
                          Spacer(),
                          Icon(Icons.arrow_forward,size: 21,color: Colors.white,),
                        ],
                      ),
                    ),
                ),
                SizedBox(height: 32,),

                InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, RegisterView.routeName);
                  },
                  child: Text('Or Create My Account ?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.primary,
                      decorationThickness: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void ValidateForm() async {
    if (formkey.currentState!.validate()) {
      viewModel.login(email.text, password.text);
    }
  }
  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routName);
  }

}