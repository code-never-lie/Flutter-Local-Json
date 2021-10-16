import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "my app",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Data"),
      ),
      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("load_json/person.json"),
            builder: (context, snapshot) {
              List mydata = json.decode(snapshot.data.toString());
              isloading = false;
              // ignore: avoid_print
              print(mydata);
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    // ignore: avoid_print
                    print(index);
                    return isloading
                        // ignore: sized_box_for_whitespace
                        ? Container(
                            height: size.height / 20,
                            width: size.height / 20,
                            child: const CircularProgressIndicator(),
                          )
                        : Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text("Name" + mydata[index]['name']),
                                Text("Age" + mydata[index]['age']),
                                Text("Hight" + mydata[index]['hight']),
                                Text("Gender" + mydata[index]['gender']),
                                Text(
                                    "Hair_color" + mydata[index]['hair_color']),
                              ],
                            ),
                          );
                  },
                  itemCount: mydata.length);
            },
          ),
        ),
      ),
    );
  }
}
