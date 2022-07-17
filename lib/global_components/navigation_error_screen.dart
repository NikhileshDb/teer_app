import 'package:flutter/material.dart';

import 'reusable_sliver.dart';

class NavigationError extends StatefulWidget {
  const NavigationError({Key? key}) : super(key: key);

  @override
  State<NavigationError> createState() => _NavigationErrorState();
}

class _NavigationErrorState extends State<NavigationError> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          const ReusableSliverAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    height: 200,
                    width: 300,
                    child: Column(
                      children: const [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 100,
                          color: Colors.red,
                        ),
                        Text(
                          'Sorry the requested resource is not available right now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(size.width * 0.70, size.height * 0.06),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     '/common_number', ModalRoute.withName('/home'));
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Home'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
