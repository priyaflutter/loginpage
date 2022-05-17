import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginpage/createpage.dart';
import 'package:loginpage/password.dart';
import 'package:loginpage/splashscreen.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splash(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Color(0xff010211),
                  image: DecorationImage(
                      image: AssetImage("animation/login.json"),
                      fit: BoxFit.fitHeight)),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    mailstatus = false;
                  });
                },
                controller: mail,
                decoration: InputDecoration(
                    // suffixIcon: IconButton(onPressed: () async {
                    //
                    //
                    // }, icon: Icon(Icons.more_vert)),
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                    labelText: "Enter Email Or Mobile No...",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xe1000211), width: 2)),
                    errorText: mailstatus ? "Pls fill Details....." : null),
              ),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    passstatus = false;
                  });
                },
                controller: pass,
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
                    labelText: "Enter Password...",
                    errorText: passstatus ? "Pls fill Details....." : null),
              ),
            ),
            InkWell(
              onTap: () async {
                String mail1 = mail.text;
                String pass1 = pass.text;

                // var email = mail.text;
                // bool emailValid = RegExp(
                //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //     .hasMatch(email);
                // print(emailValid);
                //
                // setState(() {
                //   mailstatus = emailValid;
                // });

                if (mail1.isEmpty || pass1.isEmpty) {
                  mailstatus = true;
                  passstatus = true;
                }
                else
                {
                  Map map1 = {"email": mail1, "passw": pass1};

                  var url = Uri.parse(
                      'https://priyadevani.000webhostapp.com/Apicalling/login.php');
                  var response = await http.post(url, body: map1);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  Fluttertoast.showToast(
                      msg: "Data Already Exit.....",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  

                  var logindata=jsonDecode(response.body);
                  mapview ww=mapview.fromJson(logindata);

                  String? id1=ww.userdata!.id;
                  String? name1=ww.userdata!.name;
                  String? email1=ww.userdata!.email;
                  String? contact1=ww.userdata!.contact;
                  String? password1=ww.userdata!.password;
                  String? imagename1=ww.userdata!.imagename;

                  splash.pref!.setBool("loginstatus", true);

                  splash.pref!.setString("id",id1!);
                  splash.pref!.setString("name",name1!);
                  splash.pref!.setString("email",email1!);
                  splash.pref!.setString("contact",contact1!);
                  splash.pref!.setString("password",password1!);
                  splash.pref!.setString("imagename",imagename1!);


                }



              },
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                    child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return password1();
                  },
                ));
              },
              child: Container(
                height: 25,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: double.infinity,
              child: Center(
                  child: Text(
                "__________________OR__________________",
                style: TextStyle(fontSize: 20, inherit: true),
              )),
            ),
            Text(
              "If you Don't Have Account.....",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return create1();
                  },
                ));
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff110113)),
                child: Center(
                    child: Text(
                  "Create New Account",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
          ],
        )),
      ),
    );
  }

  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool mailstatus = false;
  bool passstatus = false;

  bool show = false;

  bool? emailValid;
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

class mapview {
  int? connection;
  int? result;
  Userdata? userdata;

  mapview({this.connection, this.result, this.userdata});

  mapview.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? password;
  String? imagename;

  Userdata(
      {this.id,
      this.name,
      this.email,
      this.contact,
      this.password,
      this.imagename});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    password = json['password'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['password'] = this.password;
    data['imagename'] = this.imagename;
    return data;
  }
}
