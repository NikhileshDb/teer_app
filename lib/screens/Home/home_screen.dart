import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/teer_result.dart';

import '../../services/firebase_messaging.dart';
import '../../services/push_notification_service.dart';
import '../History/error_box.dart';
import 'list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  // Firebase cloud messaging
  @override
  void initState() {
    super.initState();
    fireBaseMessagingService(context);
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    final teerResults = Provider.of<List<TeerResult>?>(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: isDrawerOpen ? Colors.white : Colors.white,
        body: teerResults == null
            ? const ErrorBox(errorMessage: "No Results Found")
            : CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    floating: true,
                    // expandedHeight: 200,
                    title: Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                      color: Colors.blue,
                    ),
                    pinned: true,
                    centerTitle: false,
                    // leading: isDrawerOpen
                    //     ? IconButton(
                    //         icon: const Icon(Icons.arrow_back_ios),
                    //         onPressed: () {
                    //           setState(() {
                    //             xOffset = 0;
                    //             yOffset = 0;
                    //             scaleFactor = 1;
                    //             isDrawerOpen = false;
                    //           });
                    //         })
                    //     : IconButton(
                    //         icon: const Icon(Icons.menu),
                    //         onPressed: () {
                    //           setState(() {
                    //             xOffset = 230;
                    //             yOffset = 150;
                    //             scaleFactor = 0.6;
                    //             isDrawerOpen = true;
                    //           });
                    //         },
                    //       ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    // flexibleSpace: FlexibleSpaceBar(
                    //   title: const Text(
                    //     'Latest Results',
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    //   background: Image.network(
                    //     'https://i0.wp.com/www.tacticalgearslab.com/wp-content/uploads/2019/08/Best-Bow-Hunting-Gloves1.jpg',
                    //     fit: BoxFit.fitWidth,
                    //   ),
                    // ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          // DatabaseService().addDoc();
                          // DatabaseService().addCommonNumber();
                          // final result = DatabaseService()
                          //     .getCommonNumberBy(DateTime.parse("2022-04-23"));
                          // print(result);
                          Navigator.of(context).pushNamed('/settings');
                        },
                        icon: const Icon(Icons.settings),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
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
      ),
    );
  }
}
