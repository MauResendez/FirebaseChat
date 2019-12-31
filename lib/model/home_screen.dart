import 'package:camera/camera.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_chat/model/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/service/authentication.dart';
import 'chat_list_widget.dart';
import 'contact_list_widget.dart';

class Home extends StatefulWidget 
{
  // const Home(String _title, {Key key, this.auth, this.userId, this.onSignedOut}) : _title = _title, super(key: key);

  const Home(String _title, {Key key, this.auth, this.userId, this.onSignedOut, this.cameras, this.contacts}) : _title = _title, super(key: key);

  final _title;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final List<CameraDescription> cameras;
  final Future<Iterable<Contact>> contacts;
  
  State<StatefulWidget> createState() 
  {
    return _HomeState(_title);
  }
}

class _HomeState extends State<Home>
{
  final _title;

  _HomeState(String title) : _title = title;

  int _currentIndex = 0;

  Widget build(BuildContext context) 
  {
    final List<Widget> _children = [ChatListWidget(title: 'Chat', auth: widget.auth, onSignedOut: widget.onSignedOut), ContactListWidget(title: 'Chat', auth: widget.auth, onSignedOut: widget.onSignedOut, contacts: widget.contacts), CameraScreen(widget.cameras), ChatListWidget(), ChatListWidget()];

    return Scaffold
    (
      appBar: AppBar
      (
        title: Text(_title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar
      (
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: 
        [
          BottomNavigationBarItem
          (
            icon: new Icon(Icons.chat_bubble),
            title: new Text('Chats'),
          ),
          BottomNavigationBarItem
          (
            icon: new Icon(Icons.contacts),
            title: new Text('Contacts'),
          ),
          BottomNavigationBarItem
          (
            icon: Icon(Icons.camera_alt),
            title: Text('Camera')
          ),
          BottomNavigationBarItem
          (
            icon: Icon(Icons.photo_library),
            title: Text('Timeline')
          ),
          BottomNavigationBarItem
          (
            icon: Icon(Icons.language),
            title: Text('Video Chat')
          ),
        ],
      ),
    );
 }

 void onTabTapped(int index) 
  {
    setState(() 
    {
      _currentIndex = index;
      print(_currentIndex);
    });
  }

void _select(Choice choice) 
{
  switch (choice.title) 
  {
    case 'Sign out':
      _signOut();
      break;
  }
}

void _signOut() async 
{
    try 
    {
      await widget.auth.signOut();
      widget.onSignedOut();
    } 
    catch (e) 
    {
      print(e);
    }
  }
}

const List<Choice> choices = const <Choice>
[
  const Choice('Sign out'),
  const Choice('Settings')
];



class Choice 
{
  const Choice(this.title);

  final String title;
}

