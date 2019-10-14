import 'package:flutter/material.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:flutter_chat_dating_app/widgets/custom_border.dart';
import 'package:intl/intl.dart';

class ChatListHeaderItem extends StatelessWidget{
	
	final ChatModel chatModelHeading;
	
	const ChatListHeaderItem({Key key, this.chatModelHeading}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		
		var textDate = chatModelHeading.date;
		var timeDifference = DateTime.now().difference(textDate).inDays;
		
		return Row(
			mainAxisSize: MainAxisSize.max,
			crossAxisAlignment: CrossAxisAlignment.center,
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				Container(
					padding: EdgeInsets.symmetric(horizontal: 10.0),
					margin: EdgeInsets.symmetric(vertical: 10.0),
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(
							bottomLeft: Radius.circular(16.0),
							bottomRight: Radius.circular(16.0),
						),
						color: Colors.white,
						boxShadow: <BoxShadow>[
							CustomBoxShadow(
								color: Colors.grey.shade300,
								offset: new Offset(0.0, 5.0),
								blurRadius: 5.0,
								blurStyle: BlurStyle.outer,
								spreadRadius: 1.0,
							)
						],
					),
					child: Center(
						child: Text(
							timeDifference == 1 ? "Yesterday"
								:
							(timeDifference == 0 ? "Today" : new DateFormat.MMMd().format(chatModelHeading.date))
							,
							style: TextStyle(
								color: Colors.red.shade900,
								fontSize: 14.0,
							),
						),
					),
				),
			],
		);
	}
}