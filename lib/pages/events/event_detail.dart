import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Material(
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            // title: Text("SliverAppBar Title"),
            centerTitle: true,
            expandedHeight: deviceSize.height,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://picsum.photos/seed/picsum/200/300",
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black54, BlendMode.darken)),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Event name",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            "It is a long established fact that a reader will be distracted" +
                                " by the readable content of a page when looking at its layout. " +
                                "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                                " distribution of letters, as opposed to using 'Content here, content" +
                                " distribution of letters, as opposed to using 'Content here, content" +
                                " here', making it look like readable English. ",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Image.network(
                  "https://picsum.photos/seed/picsum/200/300",
                  height: deviceSize.height * 0.4,
                  width: deviceSize.width,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Text("It is a long established fact that a reader will be distracted" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " by the readable content of a page when looking at its layout. " +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      " distribution of letters, as opposed to using 'Content here, content" +
                      "The point of using Lorem Ipsum is that it has a more-or-less normal" +
                      
                      " distribution of letters, as opposed to using 'Content here, content" +
                      " here', making it look like readable English. "),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
