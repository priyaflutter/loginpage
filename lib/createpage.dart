import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class create1 extends StatefulWidget {
  const create1({Key? key}) : super(key: key);

  @override
  State<create1> createState() => _create1State();
}

class _create1State extends State<create1> {
  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          height: 690,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xfff1e2cb),
            Color(0xffc1c3c4),
            Color(0xf0ced0de)
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {

                  
                  final ImagePicker picker = ImagePicker();
                  // Pick an image
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  // final XFile? photo = await picker.pickImage(source: ImageSource.camera);

                  setState(() {
                    img = image!.path;

                  });
                  print("========${img}");



                  croppedFile = await ImageCropper().cropImage(
                    sourcePath: image!.path,

                    uiSettings: [
                      AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      IOSUiSettings(
                        title: 'Cropper',
                      ),
                    ],
                  );

                  setState(() {

                    img=croppedFile!.path;
                    print(croppedFile.runtimeType);
                  });


                },
                child: img != ""
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(img)),
                          maxRadius: 20,
                        ),
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("images/person.png"),
                              // fit: BoxFit.cover
                            ))),
              ),
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      namestatus = false;
                    });
                  },
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xe1000211), width: 2)),
                      labelText: "Name",
                      errorText: namestatus ? "Pls fill Details....." : null),
                ),
              ),
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      mailstatus = false;
                    });
                  },
                  controller: mail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Email",
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xe1000211), width: 2)),
                      errorText: mailstatus ? "Pls fill Details....." : null),
                ),
              ),
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      monostatus = false;
                    });
                  },
                  controller: mono,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xe1000211), width: 2)),
                      labelText: "Phone No",
                      errorText: monostatus ? "Pls fill Details....." : null),
                ),
              ),
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      passstatus = false;
                    });
                  },
                  controller: pass,
                  obscureText:show,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(onPressed: () {

                        setState(() {
                          show=!show;
                        });
                        
                      }, icon: Icon(show?Icons.visibility_off:Icons.visibility)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xe1000211), width: 2),
                      ),
                      labelText: "Password",
                      errorText: passstatus ? "Pls fill Details....." : null),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    String name1 = name.text;
                    String mail1 = mail.text;
                    String mono1 = mono.text;
                    String pass1 = pass.text;

                    if (name1.isEmpty ||
                        mail1.isEmpty ||
                        mono1.isEmpty ||
                        pass1.isEmpty) {
                      namestatus = true;
                      mailstatus = true;
                      monostatus = true;
                      passstatus = true;

                    }


                    
                    // Fluttertoast.showToast(
                    //     msg: "Sucessfully.....",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.CENTER,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0,
                    // );


                  });
                },
                child: Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Color(0xff0f0942),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        )),
      ),
    );
    ;
  }

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mono = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool namestatus = false;
  bool mailstatus = false;
  bool monostatus = false;
  bool passstatus = false;

  String img = "";
  CroppedFile? croppedFile;
  bool show=true;
}
