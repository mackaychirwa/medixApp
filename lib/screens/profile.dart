import 'package:flutter/material.dart';
import '../widgets/carditem.dart';
import '../widgets/stackcontainer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:  [
            const StackContainer(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>  const CardItem(),
              shrinkWrap: true,
              itemCount: 1,
            ),
          ],
        ),
      ),
    );
  }
}

