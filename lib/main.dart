import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/createpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
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
                image: DecorationImage(image: AssetImage("images/per2.jpg"),fit: BoxFit.fitHeight)
                  ),
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
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                    labelText: "Phone Or Email",
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
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: Icon(
                            show ? Icons.visibility_off : Icons.visibility)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xe1000211), width: 2)),
                    labelText: "Password",
                    errorText: passstatus ? "Pls fill Details....." : null),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  String mail1 = mail.text;
                  String pass1 = pass.text;

                  if (mail1.isEmpty || pass1.isEmpty) {
                    mailstatus = true;
                    passstatus = true;
                  }
                });
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff0f0942)),
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
            Container(
              height: 25,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: double.infinity,
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Color(0xe1000211),
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

  bool show = true;
}
