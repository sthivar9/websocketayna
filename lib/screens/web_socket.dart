import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket extends StatefulWidget {
  const WebSocket({super.key});

  @override
  State<WebSocket> createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket'),
      ),
      body: webSocketDemo(),
    );
  }
}

class webSocketDemo extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('wss://echo.websocket.org/');

  @override
  State<webSocketDemo> createState() => _webSocketDemoState(channel: channel);
}

class _webSocketDemoState extends State<webSocketDemo> {
  final WebSocketChannel channel;
  TextEditingController textController = TextEditingController();
  List<String> messageList = [];

  _webSocketDemoState({required this.channel}) {
    channel.stream.listen((data) {
      setState(() {
        print(data);
        messageList.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  cursorColor: Colors.black,
                  controller: textController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueAccent,
                      labelText: 'Send message to server',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50))),
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          channel.sink.add(textController.text);
                          textController.text = '';
                        }
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            ),
          ),
          Expanded(
            child: getMessageList(),
          )
        ],
      ),
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (String message in messageList) {
      listWidget.add(
        ListTile(
          title: Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 22.0),
              ),
            ),
            color: Colors.teal[50],
            height: 60,
          ),
        ),
      );
    }
    return ListView(children: listWidget);
  }

  @override
  void dispose() {
    textController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
