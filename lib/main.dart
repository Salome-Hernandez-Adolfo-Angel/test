import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/Gif.dart';

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<List<Gif>> _listadoGifs;
  Future<List<Gif>> _getGifs() async{
    final response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=rWZU8ezAOmrnsxZBL8tYN5Qg9Nhatk7p&limit=10&rating=g"));
    List<Gif> gifs = [];
    if(response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final jsondata = jsonDecode(body);
      print(jsondata);
      
      for(var item in jsondata["data"]){
        gifs.add(Gif(item["title"],item["images"]["downsize"]["url"]));
      }
      return gifs;
    }else{
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
   _listadoGifs = _getGifs();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}