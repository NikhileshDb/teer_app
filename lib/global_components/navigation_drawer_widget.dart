import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({
    Key? key,
  }) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    const name = "Nikhilesh";
    const email = "as@gmail.com";
    const urlImage =
        "https://media.istockphoto.com/photos/portrait-of-young-healthy-asian-woman-with-smilingcloseup-face-with-picture-id1163467378?k=20&m=1163467378&s=612x612&w=0&h=DPqsTqmGP1lWiFQbkHzWiIzgtAFfNTYYLdGTjsxoBZ8=";

    return Drawer(
      child: Material(
          color: const Color.fromRGBO(50, 75, 205, 1),
          child: ListView(
            // padding: padding,
            children: <Widget>[
              buildHeader(
                name: name,
                email: email,
                urlImage: urlImage,
                onClicked: () {
                  Navigator.of(context).pushNamed('/profile', arguments: {
                    'name': name,
                    'email': email,
                    'urlImage': urlImage
                  });
                },
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    buildSearchField(),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'People',
                      icon: Icons.people,
                      onClicked: () => slectedItem(context, 0),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Favourites',
                      icon: Icons.favorite_border,
                      onClicked: () => slectedItem(context, 1),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Workflow',
                      icon: Icons.workspaces_outline,
                      onClicked: () => slectedItem(context, 2),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Updates',
                      icon: Icons.update,
                      onClicked: () => slectedItem(context, 3),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.white70),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'Plugins',
                      icon: Icons.account_tree_outlined,
                      onClicked: () => slectedItem(context, 4),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Notifications',
                      icon: Icons.notifications_outlined,
                      onClicked: () => slectedItem(context, 5),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  slectedItem(BuildContext context, int i) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    switch (i) {
      case 0:
        {
          Navigator.of(context).pushNamed('/history');
        }
        break;
      case 1:
        {
          Navigator.of(context).pushNamed('/common_number');
        }
        break;
      case 2:
        {
          Navigator.of(context).pushNamed('/home');
        }
    }
  }

  buildHeader(
      {required String name,
      required String email,
      required String urlImage,
      VoidCallback? onClicked}) {
    return InkWell(
      onTap: onClicked,
      child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(urlImage),
              ),
              const SizedBox(width: 20),
              Column(children: [
                Text(name,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                const SizedBox(height: 4),
                Text(email,
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
              ]),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.message_outlined),
              )
            ],
          )),
    );
  }

  buildSearchField() {
    return TextField(
      // style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
        ),
      ),
    );
  }
}
