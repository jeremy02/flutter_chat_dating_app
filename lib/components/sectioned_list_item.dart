
import 'package:flutter_chat_dating_app/models/chat_model.dart';

// The base class for the different types of items the list can contain.
abstract class SectionedListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements SectionedListItem {
	final ChatModel chatModelHeading;
	
	HeadingItem(this.chatModelHeading);
}

// A ListItem that contains data to display a message.
class MessageItem implements SectionedListItem {
	final ChatModel cchatModelContent;
	
	MessageItem(this.cchatModelContent);
}