import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/user_provider.dart';

class NameWidget extends StatelessWidget {
  final String userName;
  const NameWidget(this.userName, {Key? key}) : super(key: key);

  void _getNewName(BuildContext context) {
    TextEditingController _nameTextController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Enter Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                TextField(
                  controller: _nameTextController,
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      print(_nameTextController.text);
                      Provider.of<UserProvider>(context, listen: false)
                          .updateName(_nameTextController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: (() {
              _getNewName(context);
            }),
            icon: Icon(
              Icons.edit,
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }
}
