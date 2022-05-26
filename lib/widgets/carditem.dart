import 'package:flutter/material.dart';
import 'package:untitled/classes/api/functions_api.dart';

import '../models/userdata.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: FutureBuilder(
          future: fetchUserData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: 1,
                  // itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    UserData user = snapshot.data![index];
                    return Card(
                      elevation: 8,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                              selectedColor: Colors.green,
                              leading: const Icon(
                                Icons.local_hospital_outlined,
                                size: 40,
                                color: Colors.green,
                              ),
                              title: Text(user.email,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(user.regDate.toLocal().toIso8601String()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.edit, size: 30),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const Text("No Personal Data to Display");
          }),
    );
  }
}
