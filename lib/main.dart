import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/service/authentication.dart';
import 'package:firebase_chat/theme/theme_data.dart';
import 'package:firebase_chat/model/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'model/root_page.dart';
import 'dart:async';

const title = "Firebase Chat";

List<CameraDescription> cameras; 
Future<Iterable<Contact>> contacts = ContactsService.getContacts(); 


// void main() {
//   runApp(new FirebaseChat());
// }

Future<Null> main() async
{ 
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionHandler().requestPermissions(
      [PermissionGroup.contacts, PermissionGroup.camera, PermissionGroup.microphone],
  );
  cameras = await availableCameras();
  runApp(new FirebaseChat());
}

class FirebaseChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      // home: RootPage(title: title, auth: Auth()),
      home: RootPage(title: title, auth: Auth(), cameras: cameras, contacts: contacts),
    );
  }
}