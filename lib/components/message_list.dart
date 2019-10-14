import 'package:flutter/material.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:flutter_chat_dating_app/widgets/custom_border.dart';
import 'package:intl/intl.dart';

class MessagesList extends StatefulWidget {
	
	ScrollController srollController;
	List<ChatModel> lMessageChatItems;
	GlobalKey<AnimatedListState> listKey;
	
	MessagesList({Key key, this.srollController, this.lMessageChatItems, this.listKey}) : super(key: key);
	
	@override
	MessagesListState createState() {
		return MessagesListState();
	}
}

class MessagesListState extends State<MessagesList> {
	
	@override
	Widget build(BuildContext context) {
		
		// sort the list using dates
		widget.lMessageChatItems.sort((a, b) => a.date.compareTo(b.date));
		
		// model to compare to
		ChatModel prev = widget.lMessageChatItems[0];
		bool shownHeader = false;
		
		List<ListItem> _listChildren = <ListItem>[];
		widget.lMessageChatItems.forEach((ChatModel model) {
			
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
		
		return AnimatedList(
			key: widget.listKey,
			reverse: true,
			physics: BouncingScrollPhysics(),
			shrinkWrap: true,
			initialItemCount: _listChildren.length,
			controller: widget.srollController,
			itemBuilder: (context, index, animation) => _buildItem(context, _listChildren[index], animation, index),
		);
	}
	
	Widget _buildItem(BuildContext context, ListItem item, Animation<double> animation, int index) {
		TextStyle textStyle = new TextStyle(fontSize: 20);
		
		return Padding(
			padding: const EdgeInsets.all(2.0),
			child: SizeTransition(
				sizeFactor: animation,
				axis: Axis.vertical,
				child: buildListItem(item, index),
			),
		);
	}
	
	Widget buildListItem(ListItem item, int index){
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
