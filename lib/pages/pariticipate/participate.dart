import 'package:flutter/material.dart';
import 'package:mbunge/utils/routes/routes.dart';

import 'participate_item.dart';

class ParticipatePage extends StatefulWidget {
  @override
  _ParticipatePageState createState() => _ParticipatePageState();
}

class _ParticipatePageState extends State<ParticipatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ParticipationItem(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.particiRoute);
            },
          )
        ],
      ),
    );
  }
}
