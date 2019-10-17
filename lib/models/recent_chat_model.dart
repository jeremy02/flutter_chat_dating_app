import 'dart:math';

import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:flutter_chat_dating_app/models/users_model.dart';

class RecentChatModel {
	int id;
	UserModel user;
	String lastText;
	DateTime chatTime;
	bool isFromMe;
	int unreadCount;
	
	RecentChatModel({this.id,this.user,this.lastText,this.chatTime,this.isFromMe,this.unreadCount,});
}

// random number
var rnd = new Random();

// used to generate a random count from the range given
int min = 0, max = 4;

// demo chat messages list
List<String> lDemoMessageItems = [
	"what really happens when they become chosen to leave the grocery store.",
	"Some trial work for the client.",
	"This is the story of a little penguin named Mumble who has a terrible singing voice and later discovers he has no Heartsong.",
	"Vote for your favorite community uploads created for our latest challenge",
	"Sarah",
	"Watch Happy Feet (2006) full movie online",
	"Filter quality downloads for your next project by softwares",
	"This is an Education learning app with a gamification concept. Easy to learn and fun to learn."
];


List<RecentChatModel> lRecentChats = [
	RecentChatModel(
		id: rnd.nextInt(100), user: lChatUsers[0], lastText: lDemoMessageItems[0], chatTime: lMessageItems[6].date,
		isFromMe: rnd.nextInt(100).isEven, unreadCount: min + rnd.nextInt(max - min),
	),
	RecentChatModel(
		id: rnd.nextInt(100), user: lChatUsers[1], lastText: lDemoMessageItems[1], chatTime: lMessageItems[5].date,
		isFromMe: rnd.nextInt(100).isEven, unreadCount: min + rnd.nextInt(max - min),
	),
	RecentChatModel(
		id: rnd.nextInt(100), user: lChatUsers[2], lastText: lDemoMessageItems[2], chatTime: lMessageItems[4].date,
		isFromMe: rnd.nextInt(100).isEven, unreadCount: min + rnd.nextInt(max - min),
	),
	RecentChatModel(
		id: rnd.nextInt(100), user: lChatUsers[3], lastText: lDemoMessageItems[3], chatTime: lMessageItems[3].date,
		isFromMe: rnd.nextInt(100).isEven, unreadCount: 0,
	),
	RecentChatModel(
		id: rnd.nextInt(100), user: lChatUsers[4], lastText: lDemoMessageItems[4], chatTime: lMessageItems[2].date,
		isFromMe: rnd.nextInt(100).isEven, unreadCount: min + rnd.nextInt(max - min),
	),
	RecentChatModel(
		id: rnd.nextInt(100), user: lChatUsers[5], lastText: lDemoMessageItems[5], chatTime: lMessageItems[0].date,
		isFromMe: rnd.nextInt(100).isEven, unreadCount: min + rnd.nextInt(max - min),
	),
];