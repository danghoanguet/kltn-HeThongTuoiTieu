import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kltn/view/screens/connecting_screen.dart';
import 'package:kltn/view/screens/dashboard.dart';

import 'common/constants/colors_constant.dart';
import 'data/model/WifiModel.dart';
import 'common/constants/dimens_constant.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "KLTN-HeThongTuoiTieu",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KLTN',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsConstant.kBackgroundColor,
        primaryColor: ColorsConstant.kPrimaryColor,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: ColorsConstant.kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _fbApp, //
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have an error! ${snapshot.error.toString()}");
            return Scaffold(
                body: Center(child: const Text("Something went wrong!")));
          } else if (snapshot.hasData) {
            return const MyHomePage(title: 'KLTN - Hệ Thống Tưới Tiêu');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    // _activateListener();
    super.initState();
  }
  // void _activateListener() {
  //   _database.child("Wifi/Status").onValue.listen((event) {
  //     final String wifiStatus = event.snapshot.value.toString();
  //     setState(() {
  //       _wifiStatus = wifiStatus;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // print("myHomePage build");
    DimensConstant.init(context);
    return ScreenUtilInit(
        designSize: const Size(
          DimensConstant.designWidth,
          DimensConstant.designHeight,
        ),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            body: StreamBuilder<DatabaseEvent>(
              stream: _database.child("Wifi").onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data?.snapshot.value);
                  final wifiModel = WifiModel.fromRTDB(
                      Map<String, dynamic>.from(snapshot.data?.snapshot.value
                          as Map<dynamic, dynamic>));
                  print("status: ${wifiModel.wifiStatus}\n");
                  if (wifiModel.wifiStatus == "Connected") {
                    return Dashboard();
                  } else {
                    return ConnectingScreen();
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            // body: _wifiStatus == "Connected" ? HomeScreen() : ConnectingScreen(),
          );
        });
    //});
  }
}
