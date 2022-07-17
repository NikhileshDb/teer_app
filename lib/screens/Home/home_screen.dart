import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global_components/navigation_drawer_widget.dart';
import '../../global_components/reusable_sliver.dart';
import '../../models/teer_result.dart';

import '../../services/firebase_messaging.dart';
import '../../services/push_notification_service.dart';
import 'list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Firebase cloud messaging
  @override
  void initState() {
    super.initState();
    fireBaseMessagingService(context);
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    final teerResults = Provider.of<List<TeerResult>>(context);
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      extendBody: true,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          const ReusableSliverAppBar(),
          // buildList(),
          SliverToBoxAdapter(
            child: ListView.builder(
              itemBuilder: (context, index) => ListCard(
                firstRound: teerResults[index].firstRound,
                secondRound: teerResults[index].secondRound,
                date: teerResults[index].date,
                gameProvider: teerResults[index].provider,
              ),
              itemCount: teerResults.length,
              primary: false,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
