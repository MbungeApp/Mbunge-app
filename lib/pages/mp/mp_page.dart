import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/mps/mps_cubit.dart';
import 'package:mbunge/models/mp.dart';
import 'package:mbunge/repository/mp_repository.dart';
import 'package:shimmer/shimmer.dart';

class MPPage extends StatefulWidget {
  @override
  _MPPageState createState() => _MPPageState();
}

class _MPPageState extends State<MPPage> {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("All MPs"),
      // ),
      body: Stack(
        children: [
          buildClipPath(context),
          BlocProvider(
            create: (context) => MpsCubit(MpRepository())..getMps(),
            child: RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<MpsCubit>(context).getMps();
                return _refreshCompleter.future;
              },
              child: BlocBuilder<MpsCubit, MpsState>(
                builder: (context, state) {
                  if (state is MpsInitial) {
                    return Center(
                      child: Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.white],
                        ),
                        child: Text(
                          "Mbunge App",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  }
                  if (state is MpsError) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  if (state is MpsLoaded) {
                    final List<MPs> mps = state.mps;
                    return Padding(
                      padding:
                          EdgeInsets.fromLTRB(5, kToolbarHeight / 1.5, 5, 0),
                      child: ListView.separated(
                        itemCount: mps.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return buildBanner(context);
                          } else {
                            return Card(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ConstrainedBox(
                                    constraints: BoxConstraints.expand(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: mps[index].image,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          mps[index].name,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Opacity(
                                          opacity: 0.8,
                                          child: Text(
                                            mps[index].constituency +
                                                " : " +
                                                mps[index].county,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildClipPath(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            themeData.primaryColor,
            themeData.primaryColor,
            Colors.blue,
          ],
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Members of Parliament",
            style: theme.textTheme.headline6.copyWith(
              color: Colors.white,
              fontSize: theme.textTheme.headline6.fontSize * 1.3,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "List of members of parliament an their info",
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
