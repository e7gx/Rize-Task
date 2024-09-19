import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rize/controller/services/shaerd_preferences.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:flutter/services.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _MainPageState();
}

class _MainPageState extends State<AiChatPage> {
  final List<Message> _messages = [];
  final String _firstName = 'Abdullah';

  Future<void> _saveChatHistory() async {
    List<String> messages = _messages
        .map((message) => json.encode({
              'text': message.text,
              'isMe': message.isMe,
            }))
        .toList();

    await SharedPreferencesService.saveChatHistory(messages);
  }

  final TextEditingController _textEditingController = TextEditingController();

  bool _userSentMessage = false;

  @override
  void initState() {
    super.initState();
    SharedPreferencesService.getChatHistory().then((messages) {
      setState(() {
        _messages.clear();
        _messages.addAll(messages.map((message) {
          Map<String, dynamic> parsedMessage = json.decode(message);
          return Message(
            text: parsedMessage['text'],
            isMe: parsedMessage['isMe'],
          );
        }).toList());
      });
    });
  }

  void onSendMessage() {
    String trimmedText = _textEditingController.text.trim();
    if (trimmedText.isEmpty) {
      return;
    }

    setState(() {
      _userSentMessage = true;
      Message message = Message(text: trimmedText, isMe: true);
      _messages.insert(0, message);
      _textEditingController.clear();
    });

    _saveChatHistory();

    sendMessageToChatGpt(trimmedText).then((response) {
      Message chatGptMessage = Message(text: response, isMe: false);
      setState(() {
        _messages.insert(0, chatGptMessage);
      });
      _saveChatHistory();
    }).catchError((error) {});
  }

  Future<String> sendMessageToChatGpt(String message) async {
    try {
      String prompt = """
    You are an helpful assistant in a  Rize App. 

    the username that you are helping is $_firstName.
    
    You are helping the user to get a job.

    only this data is available for now. do not ask for any other data.

    Based on the user's input, answer within the context of job searching and career improvement.

    If the user asks for help, provide a list of commands they can use.

    make the user feel comfortable and provide the best experience for him.

    make sure to provide the best answer for the user's question.

    Make sure that your respond is well structured and readable.

    Do not respond in markdown format

    your answers must be interactive with the user, use some techniques, like mentioning the user first name in the responses

    also provide good additional data based on given data that could benefits the user

    be creative and your answers must be in simple English language, do not include hard sentences or something that is not understandable by non-native english human.

    """;

      String promptMessage = "$prompt\nUser's Message: $message";

      Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
      Map<String, dynamic> body = {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": promptMessage}
        ],
        "max_tokens": 500,
      };

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${APIKey.apikey}",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse =
            json.decode(utf8.decode(response.bodyBytes));
        if (parsedResponse.containsKey('choices') &&
            parsedResponse['choices'].isNotEmpty &&
            parsedResponse['choices'][0].containsKey('message')) {
          String content = parsedResponse['choices'][0]['message']['content'] ??
              "No reply found.";
          return content;
        } else {
          return "Error: Invalid response format.";
        }
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      return "Error: Exception during API call.";
    }
  }

  Widget _buildMessage(Message message, bool isLatestMessage) {
    String imagePath =
        message.isMe ? 'assets/images/test.png' : 'assets/images/ai.png';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe)
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
            ),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.mainBlue.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: message.isMe
                  ? SelectableText(
                      message.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : isLatestMessage
                      ? TypeWriter(
                          controller: TypeWriterController(
                            text: message.text,
                            duration: const Duration(milliseconds: 5),
                          ),
                          builder: (context, value) {
                            return Text(
                              value.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          },
                        )
                      : Text(
                          message.text,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
            ),
          ),
          if (message.isMe) const SizedBox(width: 6),
          if (message.isMe)
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
            ),
        ],
      ),
    );
  }

//! KEYBOARD STYLE HERE //!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFFFFFF),
                ColorsManager.mainBlue.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              if (!_userSentMessage) _buildWelcomeMessage(),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isLatestMessage = index == 0;
                    return _buildMessage(_messages[index], isLatestMessage);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFFFFFF),
                      ColorsManager.mainBlue.withOpacity(0.3),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Divider(height: 4.h),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        cursorColor: ColorsManager.mainBlue,
                        style: TextStyle(
                          color: ColorsManager.mainBlue,
                          fontSize: 16.sp,
                        ),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          hintText: "Say Hi $_firstName ...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                        ),
                        inputFormatters: [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            if (newValue.text.isEmpty ||
                                newValue.text[0] != ' ') {
                              return newValue;
                            }
                            return oldValue;
                          }),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onSendMessage,
                      icon: const Icon(
                        Icons.rocket_launch,
                        color: ColorsManager.mainBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    if (!_userSentMessage && _textEditingController.text.isEmpty) {
      return Container(
        padding: EdgeInsets.all(5.h),
        decoration: BoxDecoration(
          color: ColorsManager.mainBlue,
          border: Border.all(color: ColorsManager.darkBlue),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                "Hello $_firstName, I'm here to help you. You can ask me anything about Rize App.",
                textAlign: TextAlign.center,
                style: TextStyles.font16WhiteWeight700.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Lottie.asset(
              'assets/animation/like1.json',
              fit: BoxFit.fitWidth,
              height: 50.h,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class Message {
  final String text;
  final bool isMe;
  Message({required this.text, required this.isMe});
}

class APIKey {
  static final apikey = dotenv.env['OPENAI_API_KEY'];
}
