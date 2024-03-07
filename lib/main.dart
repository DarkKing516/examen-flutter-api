import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()
import 'package:flutter_randomcolor/flutter_randomcolor.dart';

void main() {
  runApp(const MyApp());
  var options = Options(
      format: Format.hsl,
      count: 100,
      colorType: ColorType.blue,
      luminosity: Luminosity.light);
  var color = RandomColor.getColor(options);
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: 'Consumo API Rest',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The list that contains information about posts
  List _loadedPosts = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _loadedPosts = data;
    });
  }

  Future<void> _post() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts';

    final response = await http.post(Uri.parse(apiUrl), body: {
      'title': 'Post Title',
      'body': 'Lorem ipsum',
      'userId': '10',
    });
    final data = jsonDecode(response.body);
    print(data);
  }

  Future<void> _put() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts/id';

    final response = await http.put(Uri.parse(apiUrl), body: {
      'title': 'Post Title',
      'body': 'Lorem ipsum',
      'userId': '10',
      'Id': '1'
    });
    final data = jsonDecode(response.body);
    print(data);
  }

  Future<void> _delete() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts/id';

    final response = await http.delete(Uri.parse(apiUrl));
    final data = jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo API'),
      ),
      body: SafeArea(
        child: _loadedPosts.isEmpty
            ? Center(
                child: ElevatedButton(
                  onPressed: _fetchData,
                  child: const Text('Load Posts'),
                ),
              )
            // The ListView that displays posts
            : ListView.builder(
                itemCount: _loadedPosts.length,
                itemBuilder: (BuildContext ctx, index) {
                  // return ListTile(
                  //   title: Text(_loadedPosts[index]["title"]),
                  //   subtitle:
                  //       Text('ID: ${_loadedPosts[index]["id"]} \n${_loadedPosts[index]["body"]}'),
                  // );
                  
                  return ColoredBox(
                    color: Colors.green,
                    child: Material(
                      child: ListTile(
                        title: Text(_loadedPosts[index]["title"]),
                        subtitle: Text(
                            'ID: ${_loadedPosts[index]["id"]} \n${_loadedPosts[index]["body"]}'),
                        tileColor: Colors.cyan,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
