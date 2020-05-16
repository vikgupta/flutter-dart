import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, authSnapshot) {
        if(authSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        return StreamBuilder(
          stream: Firestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
          builder: (ctx, chatSnapshot) {
            if(chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final documents = chatSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) => MessageBubble(
                documents[index]['text'], 
                documents[index]['username'],
                documents[index]['userId'] == authSnapshot.data.uid,
                ValueKey(documents[index].documentID)
              ),
              itemCount: documents.length,
            );
          },
        );
      }
    );
  }
}