import 'package:flutter/material.dart';
import 'package:yes_no/config/helpers/get_yes_no_answer.dart';

import '../../domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {

  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola amor', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];


  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    messageList.add(Message(text: text, fromWho: FromWho.me));

    if (text.endsWith('?')) {
      await herReply();
    }
    
    notifyListeners();
    moveScrollBottom();
  }


  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();

    moveScrollBottom();
  }

  Future<void> moveScrollBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }


}