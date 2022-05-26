import 'package:flutter/material.dart';
import 'package:untitled/screens/reminder.dart';

import '../models/prescription_model.dart';

class ReminderDetail extends StatelessWidget {
  final Prescriptions dosage;
  const ReminderDetail({Key? key, required this.dosage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardImage = const NetworkImage(
        'https://source.unsplash.com/random/800x600?pills');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          iconSize: 28.0,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                const PillReminder()), (Route<dynamic> route)=> false);
          },
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Card(
                elevation: 8.0,
                child: Column(
                  children: [
                    Container(
                      height: 200.0,
                      child: Ink.image(
                        image: cardImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(dosage.prescriptionName,
                      style: const TextStyle(
                          fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text(dosage.prescriptionDosage,
                        style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                      ),),
                      trailing: Text("Prescription for: "+dosage.prescriptionDetail,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),),
                    ),


                    ButtonBar(
                      children: [
                        TextButton(
                          child: const Text('Back'),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) =>
                                const PillReminder()), (Route<dynamic> route)=> false);
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
      );
  }
}
