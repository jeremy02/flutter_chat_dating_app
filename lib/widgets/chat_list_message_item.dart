import 'package:flutter/material.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:intl/intl.dart';

class ChatListMessageItem extends StatelessWidget{
	
	final ChatModel chatModelContent;
	final bool isOdd;
	final int itemIndex;
	
	const ChatListMessageItem({Key key, this.chatModelContent, this.isOdd, this.itemIndex}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		
		final mWidth = MediaQuery.of(context).size.width * 0.75;
		
		double marginTop = itemIndex == 1 ? 10 : 20;
		
		return Row(
			mainAxisSize: MainAxisSize.max,
			mainAxisAlignment: isOdd ? MainAxisAlignment.start : MainAxisAlignment.end,
			children: <Widget>[
				Container(
					constraints: BoxConstraints(
						maxWidth: mWidth,
					),
					margin: EdgeInsets.fromLTRB(20.0, marginTop, 20.0, 20.0),
					decoration: BoxDecoration(
						color: Colors.transparent,
						borderRadius: BorderRadius.circular(10),
					),
					child: isOdd ?
					receivedMessageLayout()
						:
					sentSentMessageLayout()
					,
				),
			],
		);
	}
	
	Widget receivedMessageLayout() {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				CircleAvatar(
					radius: 18.0,
					backgroundImage:NetworkImage(
						'https://via.placeholder.com/150',
					),
					backgroundColor: Colors.transparent,
				),
				SizedBox(width: 8.0,),
				Flexible(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Text(
								chatModelContent.text,
								style: TextStyle(
									color: Colors.black,
									fontWeight: FontWeight.bold,
								),
							),
							SizedBox(height: 4.0,),
							Text(
								new DateFormat.jm().format(chatModelContent.date).toString(),
								style: TextStyle(
									fontSize: 12.0,
									color: Colors.grey.shade400,
									fontWeight: FontWeight.bold,
								),
							),
						],
					),
				),
			],
		);
	}
	
	Widget sentSentMessageLayout() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.end,
			children: <Widget>[
				Container(
					padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
					decoration: BoxDecoration(
						gradient: LinearGradient(
							stops: [0.4, 1.0],
							begin: FractionalOffset.topCenter,
							end: FractionalOffset.bottomCenter,
							colors: [
								Color.fromRGBO(238,101,95, 1.0),
								Color.fromRGBO(237,74,91, 1.0),
							],
						),
						borderRadius: BorderRadius.only(
							topRight: Radius.circular(24.0),
							topLeft: Radius.circular(24.0),
							bottomLeft: Radius.circular(24.0),
						),
					),
					child: Text(
						chatModelContent.text,
						style: TextStyle(
							color: Colors.white,
							fontWeight: FontWeight.normal,
						),
					),
				),
				SizedBox(height: 2.0,),
				Text(
					new DateFormat.jm().format(chatModelContent.date).toString(),
					style: TextStyle(
						fontSize: 12.0,
						color: Colors.grey.shade400,
						fontWeight: FontWeight.bold,
					),
				),
			],
		);
	}
}