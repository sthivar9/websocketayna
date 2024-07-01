import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:websocketayna/screens/web_socket.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text('Signed in as: ' + user.email!)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                print('Container tapped!');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebSocket()));
              },
              child: Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Text(
                  "TO WEBSOCKET SERVER CHAT",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurple[200],
              child: Text('Sign Out'),
            ),
          )
        ],
      ),
    );
  }
}
