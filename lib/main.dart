import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:untitled/screens/Login.dart';


import 'bloc/appBloc.dart';
import 'classes/app.dart';

// void main(){
//   final client = StreamChatClient(streamKey);
// runApp(
//   MyApp(
//     client: client,
//     ),
//   );
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key, required this.client}) : super(key: key);
//   final StreamChatClient client;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Health Passport',
//       builder: (context, child) {
//         return StreamChatCore(
//             client: client,
//             child: child!);
//       },
//       theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           fontFamily: 'Montserrat'),
//       home: const Login(),
//     );
//   }
// }

void main() async {
  // final client = StreamChatClient(streamKey);
  // final StreamChatClient client;
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Passport',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Montserrat'),
        home: const Login(),
      ),
    ),
  );
}
