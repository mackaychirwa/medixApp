import 'package:flutter/cupertino.dart';

class Section extends StatelessWidget {
  final children;
  final String title;
  const Section(this.title,this.children, {Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Wrap(
                spacing: 28.0,
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}
