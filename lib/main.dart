import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

List Status = [1,2,3,4,5];
final numberPhone = TextEditingController();
List getInfo_List = [];

void main() {
  runApp( MaterialApp(
    theme: ThemeData(useMaterial3: true,),
    home: MyApp(),));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

   
    return StatefulBuilder(builder: 
    (context, setState) {

       getInfo ()async{
      var pathTo1C = "http://rds2.s-line.ua:8080/1cwebservice/hs/1CAPI/orderdata";
      var getrequest = await Dio().get(pathTo1C,queryParameters: {
        'numberPhone':numberPhone.text,
        'param':'info'
      },);
      var result_DIO = json.decode(getrequest.data);
      getInfo_List.add(result_DIO['VIN']);
      setState(() {
        getInfo_List;
      },);
      print(getrequest.data);
    }

      return Scaffold(
      appBar: AppBar(title: Text("Тестове середовище для веб додатку"),),
      body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("New"),
      ),
      Center(
        child: Container(
          width: 250,
          child: TextField(
            controller: numberPhone,
            decoration: InputDecoration(
            label: Text("Номер телефона"),
          ),),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: () {
          getInfo();
        }, child: Text("Info client")),
      ),
      
      if (getInfo_List.length > 0)
        for (var i in getInfo_List)
          Row(children: [Text(i.toString())],)

    ]),);
    },);
  }
}