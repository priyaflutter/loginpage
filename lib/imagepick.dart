import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginpage/splashscreen.dart';
import 'package:loginpage/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class home1 extends StatefulWidget {
  static SharedPreferences? pref;

  const home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  String? imagepath;
  String? nameee;
  String? maillll;
  String? id;
  int currentPageIndex = 0;
  bool image1 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvalue();
    Future.delayed(Duration(seconds: 4)).then((value) {
      setState(() {
        image1 = true;
      });
    });
  }

  getvalue() {
    id = splash.pref!.getString("id") ?? "";
    imagepath = splash.pref!.getString("imagename") ?? "";
    nameee = splash.pref!.getString("name") ?? "";
    maillll = splash.pref!.getString("email") ?? "";
  }

  List<Widget> list = [Viewdata(), adddata()];

  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight -
        navibartheight -
        statusbarheight -
        appbarheight -
        navibartheight;

    return Scaffold(
        appBar: cnt == 1
            ? AppBar(
          backgroundColor: Colors.black,
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://priyadevani.000webhostapp.com/Apicalling/$imagepath'),
            )
          ],
          title: Text(
            "Addpage",
            style: TextStyle(
                fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
          ),
        )
            : AppBar(
          title: Text(
            "Viewpage",
            style: TextStyle(
                fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff111010),
                        Color(0xff666161),
                        Color(0xffd5c1c1)
                      ])),
                  currentAccountPicture: InkWell(
                      onTap: () {
                        showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                Center(
                                  child: Container(
                                    height: bodyheight * 0.25,
                                    child: Image.network(
                                        'https://priyadevani.000webhostapp.com/Apicalling/$imagepath',
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ],
                            );
                          },
                          animationType: DialogTransitionType.slideFromBottomFade,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: CircleAvatar(
                        maxRadius: bodyheight * 0.15,
                        backgroundImage: NetworkImage(
                            'https://priyadevani.000webhostapp.com/Apicalling/$imagepath'),
                      )),
                  accountName: Text(
                    "${nameee}",
                    style: TextStyle(
                      fontSize: bodyheight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "${maillll}",
                    style: TextStyle(
                      fontSize: bodyheight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      cnt = 1;
                    });
                  },
                  title: Text(
                    "Add Product",
                    style: TextStyle(
                        fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.add_shopping_cart,
                    size: bodyheight * 0.05,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: bodyheight * 0.07,
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      cnt = 0;
                    });
                  },
                  title: Text(
                    "View Product",
                    style: TextStyle(
                        fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.home,
                    size: bodyheight * 0.05,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: bodyheight * 0.07,
                  ),
                )
              ],
            )),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            currentPageIndex = index;
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
            NavigationDestination(
              icon: Icon(Icons.format_list_numbered_sharp),
              label: 'List',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_shopping_cart),
              label: 'My Cart',
            ),
          ],
        ),
        backgroundColor: Colors.pink,
        body: list[cnt]);
  }
}

class Viewdata extends StatefulWidget {
  const Viewdata({Key? key}) : super(key: key);

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
    );
  }
}

class adddata extends StatefulWidget {
  const adddata({Key? key}) : super(key: key);

  @override
  State<adddata> createState() => _adddataState();
}

class _adddataState extends State<adddata> {
  String img = "";
  CroppedFile? croppedFile;

  String? userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userid = splash.pref!.getString("id") ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;
    return Scaffold(
      // backgroundColor: Colors.green,
      body: Container(
        height: bodyheight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/cart1.gif"), fit: BoxFit.fitHeight)),
        child: Container(
          height: bodyheight,
          width: twidth,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.white12, blurRadius: bodyheight * 0.03)
          ]),
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: bodyheight * 0.25,
                    child: image != ""
                        ? CircleAvatar(
                      backgroundImage:
                      FileImage(File(imageFileList![0].path)),
                      maxRadius: bodyheight * 0.30,
                    )
                        : Container(
                        height: bodyheight * 0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/upload (2).gif"),
                                fit: BoxFit.fitHeight))),
                  ),
                  Positioned(
                    top: bodyheight * 0.18,
                    right: bodyheight * 0.14,
                    child: GestureDetector(
                      onTap: () {
                        showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        selectImages();

                                        // final ImagePicker picker =
                                        //     ImagePicker();
                                        // final XFile? photo =
                                        //     await picker.pickImage(
                                        //         source: ImageSource.camera);
                                        // setState(() {
                                        //   img = photo!.path;
                                        // });
                                        // print("========${img}");
                                        //
                                        // croppedFile =
                                        //     await ImageCropper().cropImage(
                                        //   sourcePath: photo!.path,
                                        //   uiSettings: [
                                        //     AndroidUiSettings(
                                        //         toolbarTitle: 'Cropper',
                                        //         toolbarColor: Colors.deepOrange,
                                        //         toolbarWidgetColor:
                                        //             Colors.white,
                                        //         initAspectRatio:
                                        //             CropAspectRatioPreset
                                        //                 .original,
                                        //         lockAspectRatio: false),
                                        //     IOSUiSettings(
                                        //       title: 'Cropper',
                                        //     ),
                                        //   ],
                                        // );
                                        //
                                        // setState(() {
                                        //   img = croppedFile!.path;
                                        //   print(croppedFile.runtimeType);
                                        // });

                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          height: 75,
                                          child: Image(
                                            image:
                                            AssetImage("images/camera.png"),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        selectImages();

                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          height: 100,
                                          child: Image(
                                              image: AssetImage(
                                                  "images/gallary.jpg"))),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                          animationType:
                          DialogTransitionType.slideFromBottomFade,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: bodyheight * 0.03,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: bodyheight * 0.12,
                width: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: imageFileList!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                Center(
                                  child: Container(
                                    height: bodyheight * 0.30,
                                    // margin: EdgeInsets.all(bodyheight*0.001),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                imageFileList![index].path)),
                                            fit: BoxFit.cover),
                                        color: Colors.yellow,
                                        border: Border.all(
                                            width: bodyheight * 0.003)),
                                  ),
                                ),
                              ],
                            );
                          },
                          animationType:
                          DialogTransitionType.slideFromBottomFade,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: Container(
                        height: bodyheight * 0.30,
                        // margin: EdgeInsets.all(bodyheight*0.001),
                        width: twidth * 0.25,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                FileImage(File(imageFileList![index].path)),
                                fit: BoxFit.fill),
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1)),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  selectImages();
                },
                child: Container(
                  height: bodyheight * 0.05,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Image",
                        style: TextStyle(
                            fontSize: bodyheight * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.add,
                        size: bodyheight * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: bodyheight * 0.10,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      namestatus = false;
                    });
                  },
                  controller: name,
                  decoration: InputDecoration(
                      prefixIconColor: Colors.black,
                      prefixIcon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Enter Product Name....",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 2)),
                      errorText: namestatus ? "Pls fill Details....." : null),
                ),
              ),
              Container(
                height: bodyheight * 0.10,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      catogarystatus = false;
                    });
                  },
                  controller: catogary,
                  decoration: InputDecoration(
                      prefixIconColor: Colors.black,
                      prefixIcon: Icon(
                        Icons.category,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Enter Catogary....",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 2)),
                      errorText:
                      catogarystatus ? "Pls fill Details....." : null),
                ),
              ),
              Container(
                height: bodyheight * 0.10,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      detailsstatus = false;
                    });
                  },
                  controller: details,
                  decoration: InputDecoration(
                      prefixIconColor: Colors.black,
                      prefixIcon: Icon(
                        Icons.description_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Enter Description....",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 2)),
                      errorText:
                      detailsstatus ? "Pls fill Details....." : null),
                ),
              ),
              Container(
                height: bodyheight * 0.10,
                margin: EdgeInsets.fromLTRB(10, 10, bodyheight * 0.30, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      pricestatus = false;
                    });
                  },
                  controller: price,
                  decoration: InputDecoration(
                      prefixIconColor: Colors.black,
                      prefixIcon: Icon(
                        Icons.attach_money_sharp,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Price....",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 2)),
                      errorText: pricestatus ? "Pls fill Details....." : null),
                ),
              ),
              // InkWell(onTap: () {
              //
              //   String name1 = name.text;
              //   String catogary1 = catogary.text;
              //   String details1 = details.text;
              //   String price1 = price.text;
              //
              //   if (name1.isEmpty && catogary1.isEmpty && details1.isEmpty && price1.isEmpty) {
              //     namestatus = true;
              //     catogarystatus = true;
              //     detailsstatus = true;
              //     pricestatus = true;
              //   }
              // },
              //   child: Container(
              //     height: bodyheight * 0.07,
              //     margin: EdgeInsets.fromLTRB(12, 10, bodyheight * 0.30, 0),
              //     decoration: BoxDecoration(color: Colors.white,
              //         border: Border.all(color: Colors.black,width: bodyheight*0.002),
              //         borderRadius: BorderRadius.circular(bodyheight * 0.01)),
              //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [Icon(
              //       Icons.save,
              //       color: Colors.black,
              //     ) ,Text(
              //         "Save",
              //         style: TextStyle(
              //             fontSize: bodyheight * 0.03,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black),
              //       ),],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String name1 = name.text;
          String catogary1 = catogary.text;
          String details1 = details.text;
          String price1 = price.text;

          List<int> ii =
          File(image).readAsBytesSync();
          String imagepath = base64Encode(ii);

          Map productmap = {
            "id": userid,
            "names": name1,
            "category": catogary1,
            "description": details1,
            "prices": price1,
            "image": imagepath,
          };

          if (name1.isEmpty) {
            namestatus = true;
          } else if (catogary1.isEmpty) {
            catogarystatus = true;
          } else if (details1.isEmpty) {
            detailsstatus = true;
          } else if (price1.isEmpty) {
            pricestatus = true;
          }
          else
          {

            var url = Uri.parse(
                'https://priyadevani.000webhostapp.com/Apicalling/addproduct.php');
            var response = await http.post(url, body: productmap);
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');

            // var add = jsonDecode(response.body);
            //
            // addproduct aa = addproduct.fromJson(add);
            //
            // if (aa.connection == 1) // connection
            // {
            //   if (aa.result == 1) // first time data store
            //   {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text("Add Product Sucessfully...")));
            //   }
            //   else if (aa.result == 2)
            //   {
            //     Fluttertoast.showToast(
            //         msg: "Data....",
            //         toastLength: Toast.LENGTH_SHORT,
            //         gravity: ToastGravity.CENTER,
            //         timeInSecForIosWeb: 1,
            //         backgroundColor: Colors.red,
            //         textColor: Colors.white,
            //         fontSize: 16.0);
            //   }
            // }
          }

          // Navigator.pushReplacement(context, MaterialPageRoute(
          //   builder: (context) {
          //     return home1();
          //   },
          // ));
        },
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.save,
          color: Colors.black,
        ),
        label: Text(
          "Save",
          style: TextStyle(
              fontSize: bodyheight * 0.03,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController catogary = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController price = TextEditingController();

  bool namestatus = false;
  bool catogarystatus = false;
  bool detailsstatus = false;
  bool pricestatus = false;

  String image = "";

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];


  void selectImages() async {
    List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }

    image = selectedImages[0].path;
    print("Image List Length:" + imageFileList!.length.toString());
    print("===============${image}");
    print(imageFileList);

    setState(() {});
  }
}

class addproduct {
  int? connection;
  int? result;

  addproduct({this.connection, this.result});

  addproduct.fromJson(Map<String, dynamic> json) {
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
