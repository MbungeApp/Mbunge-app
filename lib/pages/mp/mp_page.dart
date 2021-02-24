import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/mps/mps_cubit.dart';
import 'package:mbunge/models/mp.dart';
import 'package:mbunge/pages/mp/widgets/mp_detail.dart';
import 'package:mbunge/repository/mp_repository.dart';
import 'package:mbunge/widgets/error_wdget.dart';
import 'package:shimmer/shimmer.dart';

class MPPage extends StatefulWidget {
  @override
  _MPPageState createState() => _MPPageState();
}

class _MPPageState extends State<MPPage> {
  Completer<void> _refreshCompleter;
  MpsCubit mpsCubit;
  @override
  void initState() {
    mpsCubit = MpsCubit(MpRepository())..getMps();
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
            create: (context) => mpsCubit,
            child: RefreshIndicator(
              onRefresh: () async {
                await mpsCubit.getMps();
                return _refreshCompleter.future;
              },
              child: BlocListener<MpsCubit, MpsState>(
                listener: (context, state) {
                  if (state is MpsLoaded) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                  }
                },
                child: BlocBuilder<MpsCubit, MpsState>(
                  builder: (context, state) {
                    if (state is MpsInitial) {
                      return Center(
                        child: Image.asset("assets/images/loading.gif"),
                      );
                    }
                    if (state is MpsError) {
                      return ErrorAppWidget(
                        message: "An error occured",
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) {
                                      return MpDetailPage(
                                        mPs: mps[index],
                                      );
                                    }),
                                  );
                                },
                                child: MpItem(mps: mps[index]),
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

class MpItem extends StatelessWidget {
  const MpItem({
    Key key,
    @required this.mps,
  }) : super(key: key);

  final MPs mps;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: mps.image,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 5.0,
                top: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mps.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Opacity(
                    opacity: 0.9,
                    child: Text(
                      mps.county + " : " + mps.constituency,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    children: [
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          mps.bio,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Continue to read more",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
