import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function() onTap;
  const CategoryCard(
      {Key? key,
      required this.title,
      required this.iconPath,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 170,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset.zero,
                blurRadius: 15.0,),
          ],
        ),
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                height:  90,
                width: 100,
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
