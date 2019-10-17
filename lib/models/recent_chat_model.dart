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