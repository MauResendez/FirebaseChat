import 'package:flutter/material.dart';
import 'package:firebase_chat/service/authentication.dart';
import 'package:contacts_service/contacts_service.dart';    
import 'chat_screen.dart';

class ContactListWidget extends StatelessWidget 
{

  final title;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final Future<Iterable<Contact>> contacts;

  const ContactListWidget({Key key, this.title, this.auth, this.onSignedOut, this.userId, this.contacts}) : super(key: key);
  
  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      body: ListView.builder
      (
        itemCount: 20,
        itemBuilder: (context, index) 
        {
          return ListTile
          (
            title: Text('Contact $index'),
            onTap: () 
            {
              
            },
          );
        }
      ),
    );
  }
}