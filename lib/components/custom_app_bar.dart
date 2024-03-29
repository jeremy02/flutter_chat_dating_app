import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
	
	@override
	Widget build(BuildContext context) {
		return Stack(
			children: <Widget>[
				Container(
					decoration: BoxDecoration(
						gradient: LinearGradient(
							begin: Alignment.bottomLeft,
							end: Alignment.bottomRight,
							colors: [
								Color.fromRGBO(237, 79, 93, 1.0),
								Color.fromRGBO(236, 68, 91, 1.0),
							],
						),
					),
				),
				PreferredSize(
					preferredSize: Size(
						MediaQuery.of(context).size.width,
						60,
					),
					child: Padding(
						padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text(
									"Chat",
									style: TextStyle(
										fontSize: 32,
										fontWeight: FontWeight.bold,
									),
								),
								Icon(
									Icons.add,
									size: 40,
									color: Colors.white,
								),
							],
						),
					),
				),
			],
		);
	}
}