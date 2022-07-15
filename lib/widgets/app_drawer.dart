import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reeno/providers/user_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          color: Color.fromARGB(1023, 232, 232, 232),
          padding: EdgeInsets.symmetric(vertical: 32),
          width: double.infinity,
          child: Consumer<UserProvider>(
            builder: ((context, value, child) => Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(value.user!.imageUrl!),
                      // child: Image.network(value.user!.imageUrl!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        value.user!.name!,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('My Profile'),
        ),
        ListTile(
          leading: Icon(Icons.event),
          title: Text('My Bookings'),
        ),
        ListTile(
          leading: Icon(Icons.outgoing_mail),
          title: Text('Refer & Earn'),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Rate App'),
        ),
        ListTile(
          leading: Icon(Icons.support_agent),
          title: Text('Contact Us'),
        ),
        ListTile(
          leading: Icon(Icons.brightness_6_outlined),
          title: Text('Dark Mode'),
        ),
      ]),
    );
  }
}
