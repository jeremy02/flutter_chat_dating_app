

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_dating_app/components/bottom_bar.dart';
import 'package:flutter_chat_dating_app/components/custom_app_bar.dart';
import 'package:flutter_chat_dating_app/models/recent_chat_model.dart';
import 'package:flutter_chat_dating_app/models/users_model.dart';
import 'package:flutter_chat_dating_app/widgets/dashed_list_divider.dart';
import 'package:flutter_chat_dating_app/widgets/friends_list_item.dart';
import 'package:flutter_chat_dating_app/widgets/recent_chat_list_item.dart';

class HomeScreen extends StatefulWidget {
	@override
	_HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
	
	ScrollController scrollController = new ScrollController();
	
	ScrollController chatListSrollController = new ScrollController();
	
	@override
	void initState() {
		super.initState();
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
			statusBarColor: Colors.transparent,
			statusBarIconBrightness: Brightness.dark,
		));
	}
	
	@override
	void dispose() {
		super.dispose();
		scrollController.dispose();
		chatListSrollController.dispose();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: <Widget>[
					CustomAppBar(),
					Positioned.fill(
						child: Padding(
							padding: EdgeInsets.only(top: 60.0 + 20.0),
							child: Column(
								mainAxisSize: MainAxisSize.max,
								children: <Widget>[
									Padding(
										padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
										child: Container(
											height: MediaQuery.of(context).size.height * 0.14,
											child: ListView.builder(
												primary: false,
												shrinkWrap: true,
												physics: BouncingScrollPhysics(),
												scrollDirection: Axis.horizontal,
												itemCount: lChatUsers.length,
												controller: scrollController,
												itemBuilder: (BuildContext context, int index){
													return FriendsListItem(lChatUser: lChatUsers[index],);
												},
											),
										),
									),
									Expanded(
										child: Container(
											child: ClipRRect(
												borderRadius: BorderRadius.only(
													topLeft: Radius.circular(32.0),
													topRight: Radius.circular(32.0),
												),
												child: Column(
													mainAxisSize: MainAxisSize.max,
													children: <Widget>[
														Expanded(
															child: Container(
																decoration: BoxDecoration(
																	color: Colors.white,
																),
																child: Column(
																	mainAxisSize: MainAxisSize.max,
																	children: <Widget>[
																		topContainer(),
																		chatListContainer(),
																	],
																),
															),
														),
														BottomBar(),
													],
												),
											),
										),
									),
								],
							),
						),
					),
				],
			),
		);
	}
	
	Widget topContainer() {
		return Padding(
			padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Text(
						"Sunday",
						style: TextStyle(
							fontSize: 24,
							fontWeight: FontWeight.bold,
							color: Colors.black,
						),
					),
					Icon(
						Icons.more_horiz,
						size: 24,
						color: Colors.black,
					),
				],
			),
		);
	}
	
	Widget chatListContainer() {
		return Expanded(
			child: Container(
				height: double.infinity,
				margin: EdgeInsets.symmetric(horizontal: 4.0),
				child: ListView.separated(
					primary: false,
					shrinkWrap: true,
					physics: BouncingScrollPhysics(),
					scrollDirection: Axis.vertical,
					reverse: false,
					itemCount: lRecentChats.length,
					controller: chatListSrollController,
					separatorBuilder: (context, index) => DashedListDivider(
						totalWidth : MediaQuery.of(context).size.width , dashWidth: 16.0,
						emptyWidth: 16.0, dashHeight: 1.0, dashColor : Colors.grey.shade400),
					itemBuilder: (context, index){
						return RecentChatListItem(lRecentChat : lRecentChats[index]);
					},
				),
			),
		);
	}
}
