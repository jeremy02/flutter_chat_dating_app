class ChatModel {
	DateTime date;
	String text;
	
	ChatModel({this.date, this.text});
}

// get the date today
DateTime now = DateTime.now();

List<ChatModel> lMessageItems = [
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 19, 03), text: 'Text7',),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 19, 01), text: 'Text4',),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 7, 00), text: 'Text3',),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 6, 34), text: 'Text2',),
	ChatModel(date: DateTime(now.year, now.month, now.day - 1, 6, 31), text: 'Text1',),
	ChatModel(date: DateTime(now.year, now.month, now.day, 6, 31), text: 'Text6',),
	ChatModel(date: DateTime(now.year, now.month, now.day, 6, 30), text: 'Text5',),
];