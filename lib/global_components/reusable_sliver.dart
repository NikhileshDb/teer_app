import 'package:flutter/material.dart';

class ReusableSliverAppBar extends StatelessWidget {
  const ReusableSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
    );
  }
}
