import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning/main.dart';
import 'package:learning/settings.dart';
import 'package:learning/login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';


String sender = '';
bool hej = false;
List<Message> messages = [];
bool hejo = false;


class Message {
  final String text;
  final bool isSentByUser;

  Message({required this.text, this.isSentByUser = false});
}


class ChatScreen extends StatefulWidget {
  final FetchMessagesCallback startFetchingMessagesCallback;
  final FetchMessagesCallback stopFetchingMessagesCallback;
  final String titlel;

  const ChatScreen({
    Key? key,
    required this.titlel,
    required this.startFetchingMessagesCallback,
    required this.stopFetchingMessagesCallback,
  }) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late final GlobalKey<ChatScreenState> chatScreenStateKey;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    widget.startFetchingMessagesCallback();
    _controller = TextEditingController();
    // Fetch messages when the screen is initialized
    fetchMessages();
    Timer.periodic(Duration(seconds: 3), (timer) {
      fetchMessages();
      fetchData();
      if(mounted){
      setState(() {
      itemCount: messages.length;
    });
    }
    widget.startFetchingMessagesCallback();
    });
    chatScreenStateKey = GlobalKey<ChatScreenState>();
  }

Future<void> fetchData() async {
  try {
    (Message message) {
    setState(() {
      messages.add(message);
    });
    };
    List<Message> messagess = await fetchMessages(); // Make sure to await the function here
    setState(() {
      messages.addAll(messagess);
    });
  } catch (e) {
    print('Error fetching messages: $e');
  }
}

  Future<void> sendMessage(String text) async {
    String url = 'http://seeu.energokrzem.nazwa.pl/sendMessage';
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: jsonEncode({
        'recipient': widget.titlel,
        'visible': visibility,
        'text': text,
      }));

      if (response.statusCode == 200) {
        setState(() {
          messages.add(Message(text: text, isSentByUser: true));
        });
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    hejo = true;
    return Scaffold(
      appBar: AppBar(title: Text(widget.titlel)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(
                    message.text,
                    textAlign: message.isSentByUser ? TextAlign.end : TextAlign.start,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: (value) {
                      sendMessage(value);
                      _controller.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String text = _controller.text;
                    if (text.isNotEmpty) {
                      sendMessage(text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}