import 'package:flutter/material.dart';
import 'package:flutter_chat_dating_app/models/users_model.dart';

class FriendsListItem extends StatelessWidget{
	
	final UserModel lChatUser;

    const FriendsListItem({Key key, this.lChatUser}) : super(key: key);
    
	@override
	Widget build(BuildContext context) {
		return InkWell(
			onTap: (){},
			child: Container(
					constraints: BoxConstraints(
						maxWidth: MediaQuery.of(context).size.width/4,
					),
					child: Padding(
						padding: EdgeInsets.only(right: 16.0),
						child: Column(
							children: <Widget>[
								Stack(
									children: <Widget>[
										ClipOval(
											child: Image.asset(
												lChatUser.imagePath,
												fit: BoxFit.cover,
												height: MediaQuery.of(context).size.height * 0.10,
												width: MediaQuery.of(context).size.height * 0.10,
											),
										),
										Positioned.fill(
											child: ClipOval(
												child: Material(
													color: Colors.transparent,
													child: InkWell(
														splashColor: Colors.white.withOpacity(0.4),
														onTap: () {},
													),
												),
											),
										),
									],
								),
								Padding(
									padding: EdgeInsets.only(top: 8.0),
									child: Text(
										lChatUser.firstname,
										style: TextStyle(
											fontSize: 14.0,
											fontWeight: FontWeight.w300,
										),
										textAlign: TextAlign.center,
										maxLines: 1,
										overflow: TextOverflow.ellipsis,
										softWrap: false,
									),
								),
							],
						),
					),
				),
		);
	}
}