import "package:cloud_firestore/cloud_firestore.dart";
import "package:firstapp/authentication/auth_service.dart";
import "package:firstapp/components/chat_bubble.dart";
import "package:firstapp/components/my_textfield.dart";
import "package:firstapp/services/chat/chat_service.dart";
import "package:flutter/material.dart";

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String receiverID;

  ChatPage({super.key,
  required this.reciverEmail,
  required this.receiverID});

  //input message box

  final TextEditingController _messageController = TextEditingController();

  // call chat and auth

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){


      await _chatService.sendMessage(receiverID, _messageController.text);

      _messageController.clear();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(reciverEmail),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      ),
      body: Column(children: [
        Expanded(
          child: _buildMessageList(),
        ),

        _buildUserInput(),
      ],)
    );
  }
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),

      builder: (context, snapshot){
        if (snapshot.hasError){
          return const Text("Error");
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading..");
        }

        //list view of messages

        return ListView(
          children:
          snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      }
      );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
        ],
      )
      );
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(children: [
      
        Expanded(child: MyTextField(controller: _messageController,
        hintText: "Type a message",
        obscureText: false,
        ),
        ),
      
        Container(
          decoration: BoxDecoration(color: Colors.green,shape: BoxShape.circle,),
          margin: const EdgeInsets.only(right: 25),
          child: IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward,color: Colors.white,),
          ),
        )
          
        
      ],),
    );
  }

}