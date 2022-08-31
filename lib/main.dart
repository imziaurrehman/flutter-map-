import 'package:flutter/material.dart';
import 'package:fluttermap/module/location.dart';
import 'package:fluttermap/screens/user-current-loc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserLocation(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.black87,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0.0,
                centerTitle: true)),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    final getLoc = Provider.of<UserLocation>(context, listen: false);
    getLoc.userLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final getLoc = Provider.of<UserLocation>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Map"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                "Get user current location?",
                textScaleFactor: 1.4,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            ElevatedButton(
              onPressed: () async {
                await getLoc
                    .getUserCurrentLoc()
                    .then((_) => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserCurrentLoc(),
                        )));
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: const Text("get user current location"),
            ),
          ],
        ),
      ),
    );
  }
}
