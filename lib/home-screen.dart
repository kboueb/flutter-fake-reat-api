import 'dart:convert';

import 'package:api_rest/user-screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi ()async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }
    else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Posts fake API REST'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> UserScreen(),
            )
            );},
            icon: Icon(Icons.person),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text('Loading'),
                            CircularProgressIndicator(backgroundColor: Colors.orange,color: Colors.blue,)
                          ],
                        ),
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                         CircleAvatar(
                                          child: Text(postList[index].id.toString(), style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text(postList[index].runtimeType.toString().toUpperCase(), style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          color: Colors.orange
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                    child: Text(postList[index].title.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                                    child: Text(postList[index].body.toString(), textAlign: TextAlign.justify,),
                                  ),
                                  const SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                        );
                    });
                  }
              },
            ),
          )
        ]
      ),
    );
  }
}
