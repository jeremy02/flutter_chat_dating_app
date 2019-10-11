import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:flutter_chat_dating_app/widgets/custom_border.dart';
import 'package:intl/intl.dart';

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
		// sort the list using dates
		lMessageItems.sort((a, b) => a.date.compareTo(b.date));
		
		// model to compare to
		ChatModel prev = lMessageItems[0];
		bool shownHeader = false;
		
		List<ListItem> _listChildren = <ListItem>[];
		lMessageItems.forEach((ChatModel model) {
			
			if (prev != null && DateTime(model.date.year, model.date.month, model.date.day) != DateTime(prev.date.year, prev.date.month, prev.date.day)) {
				shownHeader = false; // if dates are different, beginning of a new group, so header is yet to be shown
			}
			
			if (!shownHeader) {
				// if header for a group is not shown yet, add it to the list
				_listChildren.add(HeadingItem(model));
				prev = model; // keep the current model for reference to check if group has changed
				shownHeader = true;
			}
			
			_listChildren.add(MessageItem(model));
			
		});
		
		_listChildren = _listChildren.reversed.toList();
		
		return Expanded(
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
				child: _listChildren.length <= 0 ?
					null
					:
					ListView.builder(
						itemCount: _listChildren.length,
						reverse: true,
						physics: BouncingScrollPhysics(),
						shrinkWrap: true,
						controller: chatMessagesSrollController,
						itemBuilder: (context, index) {
							final item = _listChildren[index];
							
							
							if (item is HeadingItem) {
								
								final textDate = item.heading.date;
								final dateNow = DateTime.now();
								final difference = dateNow.difference(textDate).inDays;
								
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
													difference == 1 ? "Yesterday"
														:
													(difference == 0 ? "Today" : new DateFormat.MMMd().format(item.heading.date))
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
							}else if (item is MessageItem) {
								return messageItemComponent(item.content, context, index.isOdd,index);
							}else{
								return null;
							}
						},
					),
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
									// create new model and
									// add to list at index 0
									lMessageItems.insert(0, ChatModel(
										date: DateTime.now(),
										text: message,
									));
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