import 'package:flutter/material.dart';
import 'package:prakmob_api/service.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Model? model;
  bool isLoading = false;

  TextEditingController control = TextEditingController();

  @override
  void initState() {
    isLoading = true;
    getUser('1').then((value) {
      model = value;
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('reqres test', style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    TextField(controller: control, keyboardType: TextInputType.number),
                    ElevatedButton(
                        onPressed: () {
                          getUser(control.text).then((value) {
                            model = value;
                            print(model?.data.email);
                          });
                          isLoading = false;
                          print(isLoading);
                          setState(() {});
                        },
                        child: Text('cari')),
                    CircleAvatar(
                        radius: 50, backgroundImage: NetworkImage(model!.data.avatar)),
                    Text(model!.data.firstName),
                    Text(model!.data.lastName),
                    Text(model!.data.email),
                  ],
                ),
        ));
  }
}
