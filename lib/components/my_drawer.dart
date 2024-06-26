import 'package:firstapp/authentication/auth_service.dart';
import 'package:firstapp/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final _authServe = AuthService();
    _authServe.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: Column(children: 
      [
        //label logo
        DrawerHeader(child: Center(child: Icon(
          Icons.message,
          color: Theme.of(context).colorScheme.primary,
          size: 40,
        ),)),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: ListTile(
            title: Text("H O M E"),
            leading: Icon(Icons.home),
            onTap: (){
              Navigator.pop(context);
            }
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: ListTile(
            title: Text("S E T T I N G S"),
            leading: Icon(Icons.settings),
            onTap: (){
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(),
                )
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
          child: ListTile(
            title: Text("L O G O U T"),
            leading: Icon(Icons.logout),
            onTap: logout,
          ),
        ),
      ],)
    );
  }
}