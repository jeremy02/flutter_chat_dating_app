import 'package:flutter/material.dart';
import 'package:flutter_chat_dating_app/models/chat_model.dart';
import 'package:flutter_chat_dating_app/models/sectioned_list.dart';
import 'package:flutter_chat_dating_app/models/users_model.dart';
import 'package:flutter_chat_dating_app/widgets/chat_list_header_item.dart';
import 'package:flutter_chat_dating_app/widgets/chat_list_message_item.dart';

class MessagesListComponent extends StatelessWidget {
	
	ScrollController srollController;
	List<ChatModel> lMessageChatItems;
	UserModel chatUser;
	GlobalKey<AnimatedListState> listKey;
	
	MessagesListComponent({Key key, this.srollController, this.lMessageChatItems, this.listKey, this.chatUser}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		
		// sort the list using dates
		lMessageChatItems.sort((a, b) => a.date.compareTo(b.date));
		
		// model to compare to
		ChatModel prev = lMessageChatItems[0];
		bool shownHeader = false;
		
		List<SectionedListItem> _listChildren = <SectionedListItem>[];
		lMessageChatItems.forEach((ChatModel model) {
			
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
			key: listKey,
			reverse: true,
			physics: BouncingScrollPhysics(),
			shrinkWrap: true,
			initialItemCount: _listChildren.length,
			controller: srollController,
			itemBuilder: (context, index, animation) {
				return SizeTransition(
					sizeFactor: animation,
					axis: Axis.vertical,
					child: buildListItem(_listChildren[index], index, context),
				);
			},
		);
	}
	
	Widget buildListItem(SectionedListItem item, int index, BuildContext context){
		if (item is HeadingItem) {
			
			return ChatListHeaderItem(
				chatModelHeading: item.chatModelHeading,
			);
			
		}else if (item is MessageItem) {
			
			return ChatListMessageItem(
				chatModelContent: item.chatModelContent,
				isOdd: index.isOdd,
				itemIndex: index,
				chatUser : chatUser,
			);
			
		}else{
			return null;
		}
	}
}

