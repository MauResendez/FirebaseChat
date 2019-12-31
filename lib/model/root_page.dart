import 'package:camera/camera.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/service/authentication.dart';

import 'chat_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RootPage extends StatefulWidget 
{
  // RootPage({this.title, this.auth});
  RootPage({this.title, this.auth, this.cameras, this.contacts});

  final String title;
  final BaseAuth auth;
  final List<CameraDescription> cameras;
  final Future<Iterable<Contact>> contacts;
  

  @override
  State<StatefulWidget> createState() => _RootPageState(title);
}

enum AuthStatus 
{
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> 
{
  final String _title;

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  _RootPageState(String title) : _title = title;


  @override
  void initState() 
  {
    super.initState();
    widget.auth.getCurrentUser().then((user) 
    {
      setState(() 
      {
        if (user != null) 
        {
          _userId = user?.uid;
        }

        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() 
  {
    widget.auth.getCurrentUser().then((user) 
    {
      setState(() 
      {
        _userId = user.uid.toString();
      });
    });

    setState(() 
    {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() 
  {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() 
  {
    return Scaffold
    (
      body: Container
      (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    switch (authStatus) 
    {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginScreen
        (
          title: _title,
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) 
        {
          // return ChatScreen(
          //   'Firebase Chat',
          //   auth: widget.auth,
          //   onSignedOut: _onSignedOut,
          // );
          return Home('Firebase Chat', auth: widget.auth, onSignedOut: _onSignedOut, cameras: widget.cameras, contacts: widget.contacts);
        } 
        else
          return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}
