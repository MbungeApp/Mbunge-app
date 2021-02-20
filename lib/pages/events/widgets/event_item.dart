import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    Key key,
    this.name,
    this.body,
    this.created,
    this.image,
    this.ontap,
  }) : super(key: key);
  final String name;
  final String body;
  final DateTime created;
  final String image;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: ontap,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 5.0,
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(
                        DateFormat.yMMMMEEEEd().format(
                          created,
                        ),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.57,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.57,
                        child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            body,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(image),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
