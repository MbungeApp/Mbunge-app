import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mbunge/models/mp.dart';

class MpDetailPage extends StatelessWidget {
  final MPs mPs;

  const MpDetailPage({Key key, this.mPs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: mPs.image,
            width: double.infinity,
            fit: BoxFit.cover,
            //height: 250,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10.0,
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          mPs.name,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(mPs.county + " / " + mPs.constituency),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.favorite),
                    SizedBox(width: 5),
                    Text(mPs.martialStatus.toUpperCase())
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    SizedBox(width: 5),
                    Text(DateFormat("yyyy-MM-dd").format(mPs.dateBirth))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              "About:",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(mPs.bio),
          )
        ],
      ),
    );
  }
}
