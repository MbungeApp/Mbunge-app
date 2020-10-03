import 'package:flutter/material.dart';

class ParticipationItem extends StatelessWidget {
  const ParticipationItem({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      title: Text("sample title"),
      subtitle: Text("sample description"),
    );
  }
}
