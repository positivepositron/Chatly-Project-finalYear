import 'package:firstapp/authentication/auth_service.dart';
import 'package:firstapp/components/user_tile.dart';
import 'package:firstapp/pages/chat_page.dart';
import 'package:firstapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});


  //display the users

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  

  void logout(){
    final _authServe = AuthService();
    _authServe.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      elevation: 0,
      actions: [
        IconButton(onPressed: logout, icon: Icon(Icons.logout))
      ],
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUsersstream(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return const Text("Error");
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading..");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
        );
      }
      );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    //display all users except current user

    if(userData["email"] !=_authService.getCurrentUser()!.email){
    return UserTile(
      text: userData["email"],
      onTap: (){
        //tapped on user -> go to chat
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
          reciverEmail: userData["email"],
          receiverID: userData["uid"],
        ),));
      },
    );
    } else {
      return Container();
    }
  }
  //
}