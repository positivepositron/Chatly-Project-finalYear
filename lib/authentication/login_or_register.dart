import 'package:flutter/material.dart';

import 'package:firstapp/pages/login_page.dart';
import 'package:firstapp/pages/register.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void toggle(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
// yaha pe login aur register switch karne ka logic hai

  @override
  Widget build(BuildContext context){
    if(showLoginPage){
      return LoginPage(
        onTap: toggle,
      );
    }
    else {
      return RegisterPage(
        onTap: toggle,
      );
    }
  }
}