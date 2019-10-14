import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_dating_app/components/message_list.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';

class MessageScreen extends StatefulWidget {
	
	final String chatDetails;

    const MessageScreen({Key key, this.chatDetails}) : super(key: key);
	
	@override
	MessageScreenState createState() {
		return MessageScreenState();
	}
}
// The base class for the different types of items the list can contain.
abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
	final ChatModel heading;
	
	HeadingItem(this.heading);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
	final ChatModel content;
	
	MessageItem(this.content);
}

class MessageScreenState extends State<MessageScreen> {
	
	GlobalKey<AnimatedListState> listKey = GlobalKey();
	
	final messageController = TextEditingController();
	
	bool isMessageInputEdited = false;
	
	ScrollController chatMessagesSrollController = new ScrollController();
	
	AnimatedListState get _animatedList => listKey.currentState;
	
	@override
	void initState() {
		super.initState();
		// Start listening to changes in message textfield
		messageController.addListener(_messageInputChange);
	}
	
	@override
	void dispose() {
		super.dispose();
		messageController.dispose();
		chatMessagesSrollController.dispose();
	}
	
	_messageInputChange() {
		if(messageController.text.length <= 0){
		
		}
		setState(() {
			 isMessageInputEdited = (messageController.text.length > 0);
		});
	}
	
	@override
	Widget build(BuildContext context) {
		
		return Scaffold(
			appBar: PreferredSize(
				child: AppBar(
					elevation: 0.0,
					brightness: Brightness.light,
					backgroundColor: Colors.white,
					automaticallyImplyLeading: false,
					centerTitle: true,
					leading: IconButton(
						icon: Icon(
							Icons.arrow_back_ios,
							size: 28,
							color: Colors.black,
						),
						onPressed: () => Navigator.pop(context),
					),
					title: Text(
						widget.chatDetails,
						style: TextStyle(
							color: Colors.black,
							fontWeight: FontWeight.bold,
						),
					),
					actions: <Widget>[
						circleAppBarImage()
					],
				),
				preferredSize: Size.square(kToolbarHeight),
			),
			body: Stack(
				children: <Widget>[
					Positioned.fill(
						child: Container(
							decoration: BoxDecoration(
								gradient: LinearGradient(
									begin: Alignment.bottomLeft,
									end: Alignment.bottomRight,
									colors: [
										Color.fromRGBO(237,91,94, 1.0),
										Color.fromRGBO(236,67,90, 1.0),
									],
								),
							),
						),
					),
					Column(
						mainAxisSize: MainAxisSize.max,
						children: <Widget>[
							Expanded(
								flex: 1,
								child: Container(
									padding: EdgeInsets.only(bottom: 20.0),
									decoration: BoxDecoration(
										color: Colors.white,
										borderRadius: BorderRadius.only(
											bottomLeft: Radius.circular(36.0),
											bottomRight: Radius.circular(36.0),
										),
									),
									child: lMessageItems.length <= 0 ?
									null
										:
									MessagesList(
										srollController: chatMessagesSrollController,
										lMessageChatItems : lMessageItems,
										listKey : listKey,
									),
								),
							),
							createMessageInputComponent(context),
						],
					),
				],
			),
		);
	}
	
	Widget circleAppBarImage () {
		// wrapped around a column so that the avatar doesn't stretch
		return Container(
			margin: EdgeInsets.only(right: 10),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					CircleAvatar(
						radius: 20,
						backgroundImage:NetworkImage(
							'https://via.placeholder.com/150',
						),
						backgroundColor: Colors.transparent,
					)
				],
			),
		);
	}
	
	Widget createMessageInputComponent (BuildContext context) {
		// wrapped around a column so that the avatar doesn't stretch
		return Container(
			padding: EdgeInsets.fromLTRB(24, 16, 16, 12),
			decoration: BoxDecoration(
				color: Colors.transparent,
			),
			child: TextField(
				style: TextStyle(
					fontSize: 16.0,
					color: Colors.white,
				),
				cursorColor: Colors.white,
				controller: messageController,
				keyboardType: TextInputType.multiline,
				maxLines: null,
				autofocus:false,
				decoration: InputDecoration(
					contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
					prefixIcon: Icon(
						Icons.insert_emoticon,
						color: Colors.white.withOpacity(0.6),
					),
					suffixIcon: IconButton(
						icon: Icon(
							Icons.send,
							color: Colors.white.withOpacity(isMessageInputEdited ? 1.0 : 0.4),
						),
						onPressed: (){
							var message = messageController.text.trim();
							if (message !=null || message != '')
								setState(() {
									// create new model and
									// add to list at index 0
									lMessageItems.insert(0, ChatModel(
										date: DateTime.now(),
										text: message,
									));
									
									_animatedList.insertItem(0);
								});
							messageController.clear();
							
							// scroll to bottom of list
							chatMessagesSrollController.animateTo(
								0.0,
								curve: Curves.easeOut,
								duration: const Duration(milliseconds: 300),
							);
						},
					),
					hintText: "Type you message here",
					hintStyle: TextStyle(
						color: Colors.white.withOpacity(0.8),
						fontSize: 12.0,
					),
					border: OutlineInputBorder(
						borderSide: BorderSide(
							color: Colors.transparent,
							width: 1.0,
						),
						borderRadius: BorderRadius.circular(32.0),
					),
					fillColor: Color.fromRGBO(217,71,92, 1.0),
					filled: true,
					focusedBorder: OutlineInputBorder(
						borderSide: BorderSide(
							color: Colors.white.withOpacity(0.0),
							width: 0.5,
						),
						borderRadius: BorderRadius.circular(32.0),
					),
					
				),
			),
		);
	}
}