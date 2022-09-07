import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/user_provider.dart';

class NameWidget extends StatefulWidget {
  final String userName;
  const NameWidget(this.userName, {Key? key}) : super(key: key);

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _userFullName;
  void _getNewName(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Enter Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a valid name";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userFullName = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          FocusScope.of(context).unfocus();
                          _formKey.currentState!.save();
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .updateName(_userFullName!);

                          Navigator.of(context).pop();
                        }
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
              widget.userName,
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
