import 'package:flutter/material.dart';
import 'package:mbunge/models/webinar_model.dart';

class ParticipationItem extends StatelessWidget {
  final WebinarModel webinarModel;
  const ParticipationItem({
    Key key,
    @required this.webinarModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  child: Image.asset(
                    "assets/images/bg.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${webinarModel.agenda}",
                    style: theme.textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: AnimatedOpacity(
                      opacity: 0.7,
                      duration: Duration(milliseconds: 400),
                      child: Text(
                        "${webinarModel.description}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Text(
                    "By ${webinarModel.hostedBy}",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Postponed: ${webinarModel.postponed}",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
