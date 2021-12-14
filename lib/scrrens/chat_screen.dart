import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser;
class ChatScrren extends StatefulWidget {
  static const String chatRoute = 'chatRoute';

  const ChatScrren({ Key? key }) : super(key: key);

  @override
  _ChatScrrenState createState() => _ChatScrrenState();
}

class _ChatScrrenState extends State<ChatScrren> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  
  String? messageText;

  @override
  void initState() {
    super.initState();
    getUser();
  }


  void getUser(){
    try{
      final user =_auth.currentUser;
    if(user != null){
      signInUser = user;
      print(signInUser.email);
    }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.yellow[900]!,
        title: Row(
          children: [
            Image.asset('images/logo.png',height: 30,),
            const SizedBox(width: 15,),
            const Text('MessageMe'),
          ],
        ),
        actions: [
          IconButton(
            onPressed:(){
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStream(),
            
            Container(
              decoration:  BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.yellow[900]!,
                    width: 3,
                  )
                )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value){
                        messageText = value;
                      },
                      decoration:const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here....',
                        border: InputBorder.none,
                      ),
                    ),
                    ),
                    TextButton(
                      onPressed: (){
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'sender': signInUser.email,
                          'text': messageText,
                          'time': FieldValue.serverTimestamp(),
                        });
                      },
                      child: const Text(
                        'send',
                        style: TextStyle(
                          color: Color(0xff2e386b),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageStream extends StatelessWidget {
  const MessageStream({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context,snapshot){
                List<MessageLine> messageWidgets = [];
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                for (var item in messages) {
                  final messageText = item.get('text');
                  final messageSender = item.get('sender');
                  final currentUser = signInUser.email;

                  final messageWidget = MessageLine(
                    isMe: currentUser == messageSender,
                    text: messageText,
                    sender: messageSender,);
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    children: messageWidgets,
                  ),
                );
              }
              );
  }
}


class MessageLine extends StatelessWidget {

  final String sender ;
  final String text;
  final bool isMe;
  const MessageLine({
    required this.isMe,
    required this.sender ,
    required this.text,
     Key? key 
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style:  TextStyle(
              color: isMe ? Colors.yellow[900]!
              :const Color(0xff2e386b),
              fontSize: 15,
            ),
            ),
          Material(
            elevation:10,
            borderRadius: isMe ? const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
            ):const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
            ),
            color: isMe ? const Color(0xff2e386b)
            : Colors.yellow[900]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(
                '$text',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}