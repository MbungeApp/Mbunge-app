import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/blocs/participations/participations_bloc.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/network/participation_repository.dart';
import 'package:mbunge/utils/routes/routes.dart';
import 'package:mbunge/widgets/shimmer.dart';

import 'participate_item.dart';

class ParticipatePage extends StatefulWidget {
  @override
  _ParticipatePageState createState() => _ParticipatePageState();
}

class _ParticipatePageState extends State<ParticipatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ParticipationsBloc(ParticipationRepository())
          ..add(
            LoadingParticipations(),
          ),
        child: BlocBuilder<ParticipationsBloc, ParticipationsState>(
          builder: (context, state) {
            if (state is ParticipationsInitial) {
              return Center(
                child: Shimmer(
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                  ),
                  child: Text(
                    "Mbunge",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            }
            if (state is ParticipationsError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (state is ParticipationsLoaded) {
              List<Participation> participation = state.participations;
              return ListView.separated(
                itemCount: participation.length,
                itemBuilder: (context, index) {
                  return ParticipationItem(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.particiRoute,
                        arguments: participation[index],
                      );
                    },
                    title: participation[index].name,
                    desc: participation[index].body,
                    postedBy: participation[index].postedBy,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
