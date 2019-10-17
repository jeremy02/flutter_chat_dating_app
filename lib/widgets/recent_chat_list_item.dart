import 'package:flutter/material.dart';
import 'package:flutter_chat_dating_app/models/recent_chat_model.dart';
import 'package:flutter_chat_dating_app/screens/message_screen.dart';
import 'package:intl/intl.dart';

class RecentChatListItem extends StatelessWidget{
	
	final RecentChatModel lRecentChat;

    const RecentChatListItem({Key key, this.lRecentChat}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		
		var textDate = lRecentChat.chatTime;
		var timeDifference = DateTime.now().difference(textDate).inDays;
		
		return
			Material(
				child: InkWell(
					onTap: (){
						Navigator.push(
							context,
							MaterialPageRoute(
								builder: (context) => MessageScreen(recentChatDetails: lRecentChat)),
						);
					},
					child: Padding(
						padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 16.0),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: <Widget>[
								lRecentChat.unreadCount <= 0 ? Container() : badgeCount(lRecentChat.unreadCount),
								Expanded(
									child: Row(
										children: <Widget>[
											_imageContent(),
											SizedBox(
												width: 8,
											),
											_textContent(),
										],
									),
								),
								SizedBox(
									width: 10,
								),
								Text(
									timeDifference == 1 ? "Yesterday"
										:
									(timeDifference == 0 ? "Today" : DateFormat('dd/MM/yyyy').format(lRecentChat.chatTime))
									,
									style: TextStyle(
										color: Colors.black,
										fontSize: 13.0,
									),
								),
							],
						),
					),
				),
				color: Colors.transparent,
			);
	}
	
	Widget badgeCount(int unreadCount){
		return Container(
				margin: EdgeInsets.only(right: 8.0),
				padding: EdgeInsets.all(8.0),
				decoration: BoxDecoration(
					shape: BoxShape.circle,
					color: Color.fromRGBO(237,86,93, 1.0),
				),
				child: Text(
					unreadCount.toString(),
					style: TextStyle(
						color: Colors.white,
						fontSize: 14.0,
					),
				),
			);
	}
	
	Widget _imageContent() {
		return CircleAvatar(
			radius: 32.0,
			backgroundImage:AssetImage(
				lRecentChat.user.imagePath,
			),
			backgroundColor: Colors.transparent,
		);
	}
	
	Widget _textContent() {
		return Flexible(
			child: Column(
				mainAxisSize: MainAxisSize.max,
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						lRecentChat.user.fullName,
						style: TextStyle(
							color: Colors.black,
							fontSize: 16.0,
							fontWeight: FontWeight.bold,
						),
					),
					SizedBox(height: 4.0,),
					RichText(
						textAlign: TextAlign.left,
						softWrap: true,
						overflow: TextOverflow.ellipsis,
						maxLines: 1,
						text: TextSpan(children:
						<TextSpan>[
							TextSpan(text: lRecentChat.isFromMe ? "" :"You: ",
								style: TextStyle(
									color: Colors.blueGrey,
									fontWeight: FontWeight.bold,
									fontSize: 13.0,
								),
							),
							TextSpan(
								text: lRecentChat.lastText,
								style: TextStyle(
									color: Colors.grey,
									fontSize: 13.0,
								),
							),
						]
						),
					),
				],
			),
		);
	}
}