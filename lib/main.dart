import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Match',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'You Truly Matched!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> messageList = [
    'hey what\'s up cutie? glad we matched',
    'really that is so cool i thought so too!',
    'honestly i never thought about using this app it just was kind of a spur of the moment thing.. :p'
  ];

  List<Widget> currentMessageList = [];

  late TextEditingController _controller;
  int messageIndex = 0;
  bool receive = true;

  Widget genNewBubble(String message) {
    List<Widget> bubbleRow = [
      Padding(
        padding:
            receive ? EdgeInsets.only(right: 12) : EdgeInsets.only(left: 12),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: receive
              ? Image.asset(
                  'assets/matcher.jpg',
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/me.jpg', fit: BoxFit.cover),
        ),
      ),
      Expanded(
        child: ChatBubble(
          alignment: receive ? Alignment.centerLeft : Alignment.centerRight,
          backGroundColor: receive
              ? const Color.fromRGBO(105, 255, 250, 1)
              : const Color.fromRGBO(255, 45, 140, 1),
          clipper: ChatBubbleClipper6(
              type:
                  receive ? BubbleType.receiverBubble : BubbleType.sendBubble),
          child: Text(
            message,
            style: receive
                ? TextStyle(color: Colors.black)
                : TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
      child: Row(children: receive ? bubbleRow : [bubbleRow[1], bubbleRow[0]]),
    );
  }

  void newMessage() async {
    currentMessageList.add(genNewBubble(messageList[messageIndex]));
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        currentMessageList;
        receive = !receive;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      newMessage();
      receive = !receive;
      await Future.delayed(Duration(seconds: 3)).then((value) {
        currentMessageList.add(genNewBubble(messageList[2]));
        setState(() {
          currentMessageList;
          receive = !receive;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(60, 135, 255, 0.2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Expanded(
                  child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  child: Text(
                    'Chat Up Your Match!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              )),
              Expanded(
                child: Image.asset(
                  'assets/trueMatch.png',
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration:
            BoxDecoration(color: Colors.lightBlueAccent.withOpacity(0.1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: currentMessageList,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 60, 90, 0.5)),
                      height: 0.4,
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(color: Colors.black12),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, bottom: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: Color.fromRGBO(255, 60, 90, 0.2),
                              cursorRadius: Radius.circular(25),
                              cursorHeight: 25,
                              cursorWidth: 2,
                              controller: _controller,
                              maxLines: null,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                suffixIconColor:
                                    Color.fromRGBO(255, 60, 90, 0.5),
                                suffixIcon: IconButton(
                                    focusColor:
                                        Color.fromRGBO(255, 60, 90, 0.5),
                                    splashRadius: 25,
                                    splashColor:
                                        Color.fromRGBO(255, 60, 90, 0.2),
                                    onPressed: () {
                                      if (_controller.text.length > 0) {
                                        currentMessageList.add(
                                            genNewBubble(_controller.text));
                                        _controller.text = '';
                                        _controller.clearComposing();
                                        setState(() {
                                          currentMessageList;
                                          receive = !receive;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.send_sharp)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color.fromRGBO(
                                            255, 60, 90, 0.5))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(255, 60, 90, 0.2))),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(255, 60, 90, 0.5)),
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromRGBO(255, 60, 90, 0.2)),
                                labelText: 'Say Something True!',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
