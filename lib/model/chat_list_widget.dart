import 'package:flutter/material.dart';
import 'package:firebase_chat/service/authentication.dart';
import 'chat_screen.dart';
import 'select_contacts_screen.dart';

class ChatListWidget extends StatelessWidget 
{

  final title;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  const ChatListWidget({Key key, this.title, this.auth, this.onSignedOut, this.userId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) 
  {
    // return ListView.builder(itemBuilder: (context, index) 
    // {
    //   return ListTile
    //   (
    //     title: Text('Marc, Tivon, Mauricio'),
    //     //// onTap START ////
    //     onTap: () 
    //     {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => ChatScreen('Chat', auth: auth, onSignedOut: onSignedOut,)),
    //       );
    //     },
    //     //// onTap END ////
    //   );
    // });

    return new Scaffold
    (
      body: ListView.builder
      (
        itemCount: 15,
        itemBuilder: (context, index) 
        {
          return ListTile
          (
            title: Text('Chat $index'),
            onTap: () 
            {
              Navigator.push
              (
               context,
               MaterialPageRoute(builder: (context) => ChatScreen('Chat', auth: auth, onSignedOut: onSignedOut,)),
             );
            },
          );
        }
      ),
      floatingActionButton: new FloatingActionButton
      (
        child: new Icon(Icons.chat_bubble),
        heroTag: 1,
        onPressed: () // Not ready yet
        {
          // Navigator.push // Takes you to Select Contacts page to choose who you want to create a chat with
          // (
          //   context,
          //   MaterialPageRoute(builder: (context) => SelectContacts()),
          // );
        }
      ),
    );
  }
}

