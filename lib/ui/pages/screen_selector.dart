
// import 'package:flutter/material.dart';
// import 'package:watch_it/watch_it.dart';


// class ScreenSelector extends StatelessWidget with WatchItMixin {
//   ScreenSelector({Key? key}) : super(key: key);

//   void showErrorDialog(BuildContext context, String errorMessage) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color.fromARGB(250, 31, 33, 39),
//           title: const Text(
//             'Error',
//             style: TextStyle(color: Colors.white70),
//           ),
//           content: const Text(
//             "Please Check Email or Password",
//             style: TextStyle(color: Colors.white70),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void showAdminErrorDialog(BuildContext context, String errorMessage) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color.fromARGB(250, 31, 33, 39),
//           title: const Text(
//             'Error',
//             style: TextStyle(color: Colors.white70),
//           ),
//           content: const Text(
//             "You are not Admin. Please Check Email or Password",
//             style: TextStyle(color: Colors.white70),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var userData = watchValue((UserManagementService x) => x.userData);
//     bool isLoading = watchValue((NavigationService x) => x.isLoadingNotifier);

//     registerHandler(
//         select: (UserManagementService x) => x.invalidUser,
//         handler: (context, value, cancel) =>
//             showErrorDialog(context, value.toString()));
//     registerHandler(
//         select: (UserManagementService x) => x.isField,
//         handler: (context, value, cancel) {
//           if (!value) {
//             showAdminErrorDialog(context, value.toString());
//           }
//         });

//     if (isLoading == true) {
//       return const LoadingScreen();
//     } else {
//       if (userData != null) {
//         return HomePage();
//       } else {
//         return const LoginPage();
//       }
//     }
//   }
// }
