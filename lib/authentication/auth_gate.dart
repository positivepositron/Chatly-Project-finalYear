import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/authentication/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/pages/home_page.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(

        //sign-in methods and logic yaha he

        //basically ye file me authStatechanges wala method sirf changes ko listen kar raha hai aur kuch nahi
        // jaise hi change hota hai ye builder function ko invoke krta hai aur snapshot variable me data ke hisaab se kaam krta hai

        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomePage(); //logged in h user
          }
          else{
            return const LoginOrRegister(); //logged out hai user
          }
        },
      )
    );
  }
}