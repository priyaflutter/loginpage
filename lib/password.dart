import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class password1 extends StatefulWidget {
  const password1({Key? key}) : super(key: key);

  @override
  State<password1> createState() => _password1State();
}

class _password1State extends State<password1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              child: Center(
                  child: Text(
                "Enter Your Mobile Number",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              )),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    phonestatus = false;
                  });
                },
                controller: phone,
                obscureText: show,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (show == false) {
                              show = true;
                            } else {
                              show = false;
                            }
                          });
                        },
                        icon: Icon(
                            show ? Icons.visibility_off : Icons.visibility)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xe1000211), width: 2),
                    ),
                    labelText: "Phone",
                    errorText: phonestatus ? "Pls fill Details....." : null),
              ),
            ),
            InkWell(
              onTap: () async {
                String phone1 = phone.text;

                if (phone1.isEmpty) {
                  phonestatus = true;
                } else {
                  Map map11 = {
                    "mono": phone1,
                  };

                  var url = Uri.parse(
                      'https://priyadevani.000webhostapp.com/Apicalling/pass.php');
                  var response = await http.post(url, body: map11);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                  print("djjjjjjjjjjjjjj");


                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff110113)),
                child: Center(
                    child: Text(
                  "Find your account",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Container(
                        height: 70,
                        width: 70,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(""),
                        ),
                      ),
                        Container(height:70 ,
                        width: 100,
                        child: Text("${user}"),)
                      ],),
                    ),
                  );
                },
              ),
            )
          ],
        )),
      ),
    );
  }

  TextEditingController phone = TextEditingController();
  bool show = false;
  bool phonestatus = false;
  var user;

}
class viewdata {
  int? connection;
  int? result;

  viewdata({this.connection, this.result});

  viewdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
