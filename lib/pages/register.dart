import 'package:firstapp/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/button.dart';
import 'package:firstapp/components/my_textfield.dart';


class RegisterPage extends StatelessWidget{

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _pwCon = TextEditingController();
  final TextEditingController _cfpwCon = TextEditingController();

  final void Function ()? onTap;

  //login function
  void register(BuildContext context) {
    //handle auth here

    final _auth = AuthService();

    //if entered pass is same as confirm password do this
if(_pwCon.text==_cfpwCon.text){
    try{
    _auth.signUpWithEmailPassword(
      _emailCon.text, 
      _pwCon.text,
      );
    }
    catch(e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ) 
      );
    }
}
  
  else{
    showDialog(context: context, 
    builder: (context) => AlertDialog(
        title: Text("Passwords dont't match!!"),
      ) 
      );
  }

  }
  RegisterPage({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
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
              "Jai Shri Ram,Create Account Here",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            MyTextField(
              hintText: "Email goes here",
              obscureText: false,
              controller: _emailCon,
            ),

            const SizedBox(height: 10),

            MyTextField(
              hintText: "Password goes here",
              obscureText: true,
              controller: _pwCon,
            ),

            const SizedBox(height: 10),

            MyTextField(
              hintText: "retype password",
              obscureText: true,
              controller: _cfpwCon,
            ),

           const SizedBox(height: 20),

            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Text("Already have an account? Login now",
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