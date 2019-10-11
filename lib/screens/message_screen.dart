import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
	
	final String chatDetails;

    const MessageScreen({Key key, this.chatDetails}) : super(key: key);
	
	@override
	MessageScreenState createState() {
		return MessageScreenState();
	}
}
class MessageScreenState extends State<MessageScreen> {
	
	final messageController = TextEditingController();
	
	bool isMessageInputEdited = false;
	
	ScrollController chatMessagesSrollController = new ScrollController();
	
	// demo chat messages list
//	List<String> lMessageItems = [
//		"what really happens when they become chosen to leave the grocery store.",
//		"Some trial work for the client.",
//		"is about one sausage leading a group of supermarket products on a quest to discover the truth about their existence",
//		"Vote for your favorite community uploads created for our latest challenge",
//		"Sarah",
//		"Sausage Party, the first R-rated CG animated movie",
//		"Filter quality downloads for your next project by softwares",
//		"This is an Education learning app with a gamification concept. Easy to learn and fun to learn."];
	
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
							messageListComponent(context),
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
	
	Widget messageListComponent (BuildContext context) {
		// wrapped around a column so that the avatar doesn't stretch
		return Flexible(
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
					ListView.builder(
						itemCount: lMessageItems.length,
						reverse: true,
						physics: BouncingScrollPhysics(),
						shrinkWrap: true,
						controller: chatMessagesSrollController,
						itemBuilder: (context, i) => messageItemComponent(lMessageItems[i], context, i.isOdd,i),
					)
				,
			),
		);
	}
	
	Widget messageItemComponent(ChatModel lMessageItem, context, bool isOdd, int index) {
		
		final mWidth = MediaQuery.of(context).size.width * 0.75;
		
		double marginTop = index == 1 ? 10 : 20;
		
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
						receivedMessageLayout(lMessageItem)
						:
						sentSentMessageLayout(lMessageItem)
					,
				),
			],
		);
	}
	
	Widget receivedMessageLayout(ChatModel lMessageItem) {
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
								lMessageItem.text,
								style: TextStyle(
									color: Colors.black,
									fontWeight: FontWeight.bold,
								),
							),
							SizedBox(height: 4.0,),
							Text(
								new DateFormat.jm().format(lMessageItem.date).toString(),
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
	
	Widget sentSentMessageLayout(ChatModel lMessageItem) {
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
						lMessageItem.text,
						style: TextStyle(
							color: Colors.white,
							fontWeight: FontWeight.normal,
						),
					),
				),
				SizedBox(height: 2.0,),
				Text(
					new DateFormat.jm().format(lMessageItem.date).toString(),
					style: TextStyle(
						fontSize: 12.0,
						color: Colors.grey.shade400,
						fontWeight: FontWeight.bold,
					),
				),
			],
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
									
									// create new model
									ChatModel newChat = new ChatModel();
									newChat.date = DateTime.now();
									newChat.text = message;
									
									// add to list at index 0
									lMessageItems.insert(0, newChat);
								});
							messageController.clear();
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