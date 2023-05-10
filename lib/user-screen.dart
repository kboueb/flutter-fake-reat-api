import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/PostModel.dart';
import 'models/UserModel.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi ()async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      userList.clear();
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Posts fake API REST'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      child: Center(
                        child: Column(
                          children: const [
                            Text('Loading'),
                            CircularProgressIndicator(backgroundColor: Colors.orange,color: Colors.blue,)
                          ],
                        ),
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: userList.length,
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
                                          child: Text(userList[index].name.toString().substring(0,1), style: Theme.of(context).textTheme.titleLarge,),
                                          backgroundColor: Colors.blue,

                                        ),
                                        const SizedBox(width: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(userList[index].name.toString().toUpperCase(), style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              color: Colors.blue
                                            ),),
                                            Text(userList[index].email.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20,),
                                        Text('${userList[index].company?.name.toString()}', style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5,),
                                        Text('${userList[index].company?.catchPhrase.toString()}', style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5,),
                                        Text('${userList[index].company?.bs.toString()}', style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(height: 8,),
                                        Divider(height: 1,color: Colors.blueGrey),
                                        SizedBox(height: 8,),
                                        Text('${userList[index].address?.city.toString()} | ${userList[index].address?.street.toString()} | ${userList[index].address?.suite.toString()}'),
                                        SizedBox(height: 5,),
                                        Text('${userList[index].website.toString()}'),
                                        SizedBox(height: 5,),
                                        Text('${userList[index].phone.toString()}'),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
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
