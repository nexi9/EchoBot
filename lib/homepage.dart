import 'package:flutter/material.dart';
import 'package:myapp/api.dart';
import 'package:myapp/chatmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isfocused = false;
  bool _isused = false;
  bool _isPressed = false;
  String userText = "";

  List<ChatMsg> txt = [];

  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isfocused = _focusNode.hasFocus;
      });
    });
  }

  void getMessage() async {
    setState(() {
      userText = _controller.text;
      txt.add(ChatMsg(text: userText, chat: chatMsgType.user));
    });
    var botMssg = await ApiServices.apiFetch(userText);
    setState(() {
      txt.add(ChatMsg(text: botMssg, chat: chatMsgType.bot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.add)],
        title: Center(child: Text("Welcome to EchoBot")),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: txt.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          chatBox(text: txt[index].text, chat: txt[index].chat),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 320,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter text",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send,
                                color: _isfocused ? Colors.black : Colors.grey),
                            onPressed: getMessage,
                          )),
                      focusNode: _focusNode,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: IconButton(
                          onPressed: () {
                            if (_isused == true) {
                              setState(() {
                                _isused = false;
                              });
                            } else {
                              setState(() {
                                _isused = true;
                              });
                            }
                          },
                          icon: Center(
                            child: Icon(
                                size: 40,
                                color: _isused ? Colors.black : Colors.grey,
                                Icons.mic),
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatBox({required text, required chatMsgType? chat}) {
    return Row(
      children: [
        Icon(Icons.circle, size: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
                maxLines: 5,
              ),
            ),
            height: 70,
            width: 300,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12)),
          ),
        )
      ],
    );
  }
}
