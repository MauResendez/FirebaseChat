import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';    

Future<Iterable<Contact>> contacts = ContactsService.getContacts(); // Loop through contacts to see if they have the app or not to post those contacts on the list

class SelectContacts extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    return null; // Get selected contacts
    CreateChat(); // Create chat for the users by creating a unique Chat ID for it and to put all contact's selected ID on it.
  }
}

void CreateChat() // Will implement soon
{
  
}