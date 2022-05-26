import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/topbar.dart';

import '../classes/api/functions_api.dart';
import '../models/userdata.dart';
import 'customclipper.dart';

class StackContainer extends StatelessWidget {
  const StackContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 1,
                // itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  UserData userData = snapshot.data![index];
                  return Container(
                    height: 300.0,
                    child: Stack(
                      children: [
                        Container(),
                        ClipPath(
                          clipper: MyCustomClipper(),
                          child: Container(
                            height: 300.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://source.unsplash.com/random/800x600?green',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, 1.6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProfileAvatar(
                                "https://picsum.photos/200",
                                borderWidth: 4.0,
                                radius: 60.0,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                               Text(
                                userData.email,
                                style: const TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userData.phone,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const TopBar(),
                      ],
                    ),
                  );
                });
          }
          return const Text("data");
        });
  }
}
