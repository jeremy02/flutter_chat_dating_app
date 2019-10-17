import 'package:flutter_chat_dating_app/models/recent_chat_model.dart';

class ChatModel {
	DateTime date;
	String text;
	
	ChatModel({this.date, this.text});
}

// get the date today
DateTime now = DateTime.now();

List<ChatModel> lMessageItems = [
	ChatModel(date: DateTime(now.year, now.month, now.day - 3, 19, 03), text: lDemoMessageItems[7],),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 19, 01), text: lDemoMessageItems[6],),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 7, 00), text: lDemoMessageItems[5],),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 6, 34), text: lDemoMessageItems[4],),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 6, 31), text: lDemoMessageItems[3],),
	ChatModel(date: DateTime(now.year, now.month, now.day, 6, 31), text: lDemoMessageItems[2],),
	ChatModel(date: DateTime(now.year, now.month, now.day, 6, 30), text: lDemoMessageItems[1],),
	ChatModel(date: DateTime(now.year, now.month, now.day, 6, 25), text: lDemoMessageItems[0],),
];