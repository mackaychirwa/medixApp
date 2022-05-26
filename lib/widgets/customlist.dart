import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  const CustomListTile(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        8.0,
        0,
        8.0,
        0,
      ),
      child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.green,
              ),
            ),
          ),
          child: InkWell(
            splashColor: Colors.orange[600],
            onTap: onTap,
            child: Container(
              
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Icon(Icons.arrow_right)
                ],
              ),
            ),
          )),
    );
  }
}
