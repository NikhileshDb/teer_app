import 'package:flutter/material.dart';
import 'package:teer_common/screens/Home/list_card.dart';
import 'package:teer_common/services/database/database_service.dart';

class LatestResultCard extends StatelessWidget {
  const LatestResultCard({
    Key? key,
    required this.providerName,
  }) : super(key: key);
  final String providerName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().getSingleResult(providerName),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListCard(
              firstRound: snapshot.data[0].firstRound,
              secondRound: snapshot.data[0].secondRound,
              date: snapshot.data[0].date,
              gameProvider: snapshot.data[0].provider,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
