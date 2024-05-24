import 'package:firstapp/authentication/auth_service.dart';
import 'package:firstapp/components/button.dart';
import 'package:firstapp/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{

  // email and text controller
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _pwCon = TextEditingController();
  // logic to toggle pages

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login function
  void login(BuildContext context) async{
    //handle auth here
    final authService = AuthService();

    try{
      await authService.signInWithEmailPassword(_emailCon.text, _pwCon.text);
    }
    catch (e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ) 
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          
         
          Icon(Icons.message,size:60,
          color: Theme.of(context).colorScheme.primary),

          const SizedBox(height:50),

          Text(
              "Chatly Final Year Project",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 50),

          MyTextField(
            hintText: "Email goes here",
            obscureText: false,
            controller: _emailCon,
          ),

          const SizedBox(height: 15),

          MyTextField(
            hintText: "Password goes here",
            obscureText: true,
            controller: _pwCon,
          ),

          const SizedBox(height: 25),

          MyButton(
            text: "Login",
            onTap: () => login(context),
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Text("Register now",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          )
        ],

      ),
      ),
    );
  }
}