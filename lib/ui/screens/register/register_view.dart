import 'package:chat/providers/provider.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/home/home_view.dart';
import 'package:chat/ui/screens/login/login_view.dart';
import 'package:chat/ui/screens/register/register_navigator.dart';
import 'package:chat/ui/screens/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  static String routeName = 'Register View';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseView<RegisterView,RegisterViewModel>
implements RegisterNavigator{
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visable = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage('assets/bg.png'),fit: BoxFit.fill),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 32,
            ),
            backgroundColor: Colors.transparent,
            title: Text('Register',style: TextStyle(
              color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold,
            ),),
            centerTitle: true,
            elevation: 0.0,

          ),
          body: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.fromLTRB(20,20,20,50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (text){
                      if(text!.trim() == ''){
                        return "Please Enter Name";
                      }
                      return null;
                    },
                    controller: namecontroller,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Please Enter Your Name',
                      hintStyle: TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                      suffixIcon: Icon(Icons.person,color: Theme.of(context).colorScheme.primary,size: 26,),
                      focusColor: Colors.cyan,
                      border: UnderlineInputBorder(borderSide: BorderSide(
                        color: Colors.cyan,
                      )),
                      labelText: 'Name',
                      labelStyle:  TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                    ),
                  ),

                  SizedBox(height: 20,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Please enter e-mail',
                      hintStyle: TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                      suffixIcon: ImageIcon(AssetImage('assets/Iconfettle.png',),color: Theme.of(context).colorScheme.primary,size: 40, ),
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
                    textInputAction: TextInputAction.done,
                    validator: (text){
                      if(text!.trim() == ''){
                        return "Please Enter Password";
                      }
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      return null;
                    },
                    controller: passwordController,
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

                 Spacer(),

                  ElevatedButton(onPressed: (){
                    validateAccount();
                  },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text('Create Account',textAlign: TextAlign.start,
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
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, LoginView.routeName);
                    },
                    child: Text('Already Have Account ?',
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
      ),
    );
  }
  void validateAccount(){
    if(formkey.currentState!.validate()){
      viewModel.CreateAccountWithFireBaseAuth(
          namecontroller.text,emailController.text, passwordController.text
      );
    }
  }

  @override
  void goToHome(MyUser) {
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routName);
  }
}
