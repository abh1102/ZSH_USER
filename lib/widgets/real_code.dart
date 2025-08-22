// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:zanadu/common/logic/provider/chat_provider.dart';
// import 'package:zanadu/core/constants.dart';
// import 'package:zanadu/core/routes.dart';
// import 'package:zanadu/features/health_coach/logic/provider/discovery_provider.dart';
// import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';
// import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
// import 'package:zanadu/features/login/logic/provider/login_provider.dart';
// import 'package:zanadu/features/offerings/logic/provider/offering_provider.dart';
// import 'package:zanadu/features/onboarding/presentations/splash_screen.dart';
// import 'package:zanadu/features/profile/logic/provider/edit_profile_provider.dart';
// import 'package:zanadu/features/signup/logic/provider/signup_provider.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (Platform.isIOS) {
//     await Firebase.initializeApp(
//         options: const FirebaseOptions(
//             iosBundleId: "com.zanaduhealth.beta",
//             storageBucket: "zanaduhealth-staging.appspot.com",
//             apiKey: "AIzaSyBWBydJgUrUBzoN3tieR_mwcf_UvskCgrs",
//             appId: "1:1078262936239:ios:7fa3ad9d068c659d085a5a",
//             messagingSenderId: "1078262936239",
//             projectId: "zanaduhealth-staging"));
//   } else {
//     await Firebase.initializeApp(
//         options: const FirebaseOptions(
//             apiKey: "AIzaSyD1ZvAwVJ54MijMy3mQivOG3xR_HOfkiLE",
//             appId: "1:1078262936239:android:84511bee5f632ea8085a5a",
//             messagingSenderId: "1078262936239",
//             projectId: "zanaduhealth-staging"));
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   try {
//     print("starting");
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     print("Firebase initialized successfully. starting");
//   } catch (e) {
//     print("Error initializing Firebase: $e");
//   }
//   print("Initializing Firebase...");
//   try {
//     if (Platform.isIOS) {
//       print("iso is running");
//       await Firebase.initializeApp(
//           options: const FirebaseOptions(
//               iosBundleId: "com.zanaduhealth.beta",
//               storageBucket: "zanaduhealth-staging.appspot.com",
//               apiKey: "AIzaSyBWBydJgUrUBzoN3tieR_mwcf_UvskCgrs",
//               appId: "1:1078262936239:ios:7fa3ad9d068c659d085a5a",
//               messagingSenderId: "1078262936239",
//               projectId: "zanaduhealth-staging"));
//     } else {
//       print("android is running");

//       await Firebase.initializeApp(
//           options: const FirebaseOptions(
//               apiKey: "AIzaSyD1ZvAwVJ54MijMy3mQivOG3xR_HOfkiLE",
//               appId: "1:1078262936239:android:84511bee5f632ea8085a5a",
//               messagingSenderId: "1078262936239",
//               projectId: "zanaduhealth-staging"));
//     }

//     print("Firebase initialized successfully.");
//   } catch (e) {
//     print("hello");
//   }

//   print("Firebase initialized successfully.");

//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(const MyApp());
//   });

//   final initialUri = Uri.base;
//   Routes.handleDeepLink(initialUri);
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.dark,
//     ));

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => LoginCubit()),
//       ],
//       child: MultiProvider(
//         providers: [
//           ChangeNotifierProvider<SignUpProvider>(
//             create: (context) => SignUpProvider(context),
//           ),
//           ChangeNotifierProvider<LoginProvider>(
//             create: (context) => LoginProvider(context),
//           ),
//           ChangeNotifierProvider<EditProfileProvider>(
//             create: (context) => EditProfileProvider(context),
//           ),
//           ChangeNotifierProvider<QuestionProvider>(
//             create: (context) => QuestionProvider(),
//           ),
//           ChangeNotifierProvider<OfferingProvider>(
//             create: (context) => OfferingProvider(),
//           ),
//           ChangeNotifierProvider<TabIndexProvider>(
//             create: (context) => TabIndexProvider(),
//           ),
//           ChangeNotifierProvider<GroupChatProvider>(
//             create: (context) => GroupChatProvider(),
//           ),
//         ],
//         child: ScreenUtilInit(
//           builder: (context, child) => Builder(
//             builder: (context) => MaterialApp(
//               builder: (context, child) {
//                 return MediaQuery(
//                   data: MediaQuery.of(context)
//                       .copyWith(textScaler: const TextScaler.linear(1.0)),
//                   child: child!,
//                 );
//               },
//               debugShowCheckedModeBanner: false,
//               theme: Themes.defaultTheme,
//               navigatorKey: Routes.navigatorKey,
//               home: const SplashScreen(),
//               onGenerateRoute: Routes.onGenerateRoute,
//               // initialRoute: Screens.splash,
//             ),
//           ),
//           designSize: const Size(430, 932),
//         ),
//       ),
//     );
//   }
// }
