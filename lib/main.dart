import 'package:flutter/material.dart';

import 'album.dart';
import 'network_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAlbum = NetworkManager().fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('http example')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter Title'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  futureAlbum = NetworkManager().createAlbum(_controller.text);
                });
              },
              child: const Text('Create Data'),
            ),
            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(child: Text(snapshot.data!.title));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
