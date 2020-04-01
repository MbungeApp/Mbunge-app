import 'package:flutter/material.dart';

class ParticipationItem extends StatelessWidget {
  const ParticipationItem(
      {Key key, this.onTap, this.title, this.desc, this.postedBy})
      : super(key: key);
  final Function onTap;
  final String title;
  final String desc;
  final String postedBy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                postedBy,
                style:Theme.of(context).textTheme.caption
              ),
            )
          ],
        ),
      ),
    );
  }
}
