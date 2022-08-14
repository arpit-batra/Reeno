import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/widgets/app_drawer_widgets/name_widget.dart';
import 'package:reeno/widgets/app_drawer_widgets/profile_pic_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  static const appDrawerWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: appDrawerWidth,
      child: Drawer(
        child: Column(children: [
          Container(
            color: const Color.fromARGB(1023, 232, 232, 232),
            padding: const EdgeInsets.symmetric(vertical: 32),
            width: double.infinity,
            child: Consumer<UserProvider>(
              builder: ((context, value, child) => Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        ProfilePicWidget(value.user!.imageUrl!),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(child: NameWidget(value.user!.name!)),
                      ],
                    ),
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
      ),
    );
  }
}
