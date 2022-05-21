import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginpage/createpage.dart';
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
                  "Homepage",
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
  List<Map> list = [];

  List imagelist = [
    "images/fashion.jpg",
    "images/Health.jpg",
    "images/mobile.jpg",
    "images/furniture.jpg",
    "images/books.jpg",
    "images/cosmetics.jpg",
    "images/surgical.jpg",
    "images/toy.jpg",
  ];
  List catogaryy = [
    "Fashion & Beauty",
    "Health & Personal Care",
    "Mobile & Electronics Devices",
    "Home & Furniture",
    "Books & Education",
    "Cosmetics",
    "Surgical",
    "Toy Children & Baby",
  ];

  

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;

    return Scaffold(
      // backgroundColor: Colors.yellow,
      body: Container(
        height: bodyheight,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffecd9d9),
            Color(0xffe0cccc),
            Color(0xffd5c1c1)
          ]),
        ),
        child: ListView(
          children: [
            Container(
              height: bodyheight * 0.05,
              child: TextField(
                onChanged: (value) {},
                controller: search,
                decoration: InputDecoration(
                  suffixIconColor: Colors.black,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(bodyheight * 0.002))),
                  labelText: "Search here....",
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, width: bodyheight * 0.001)),
                ),
              ),
            ),
            Container(
              height: bodyheight * 0.90,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: bodyheight * 0.03)
              ]),
              margin: EdgeInsets.fromLTRB(
                  bodyheight * 0.01, bodyheight * 0.01, bodyheight * 0.01, 0),
              child: AlignedGridView.count(
                crossAxisCount: 2,
                itemCount: catogaryy.length,
                mainAxisSpacing: bodyheight * 0.02,
                crossAxisSpacing: bodyheight * 0.02,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return create1();
                        },
                      ));
                    },
                    child: Container(
                      height: bodyheight * 0.30,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(bodyheight * 0.02))),
                        child: Container(
                          height: bodyheight * 0.28,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(bodyheight * 0.02)),
                            image: DecorationImage(
                                image: AssetImage(imagelist[index]),
                                fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xfff1efef),
                                  blurRadius: bodyheight * 0.03),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: bodyheight * 0.05,
                              ),
                              Text(
                                catogaryy[index],
                                style: TextStyle(
                                    fontSize: bodyheight * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController search = TextEditingController();
}

class adddata extends StatefulWidget {
  const adddata({Key? key}) : super(key: key);

  @override
  State<adddata> createState() => _adddataState();
}

class _adddataState extends State<adddata> {


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
      body: SingleChildScrollView(physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: bodyheight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/cart1.gif"), fit: BoxFit.fitHeight)),
            child: Container(
              height: bodyheight,
              width: twidth,
              margin: EdgeInsets.all(bodyheight*0.01),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.white12, blurRadius: bodyheight * 0.03)
              ]),
              child: Column(
                children: [
                  Container(
                    height: bodyheight * 0.18,
                    width:double.infinity,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 2)
                    // ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:imagelist.length,
                      itemBuilder: (context, index) {

                        return InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();

                            final XFile? image =
                                await picker.pickImage(source: ImageSource.gallery);

                            setState(() {
                                  imagelist[index] = image!.path;
                            });

                          },
                          child:imagelist[index] ==""?Container(
                              height: bodyheight * 0.10,
                              width: twidth * 0.30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/upload (2).gif"),
                                      fit: BoxFit.fitHeight)))
                              :Container(
                            height: bodyheight * 0.05,
                            margin: EdgeInsets.all(bodyheight*0.01),
                            width: twidth * 0.30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(imagelist[index])),
                                    fit: BoxFit.fill),
                                border: Border.all(width: 1)),
                          ),
                        );

                      },

                    ),
                  ),

                  Container(
                    height: bodyheight * 0.10,
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                    margin: EdgeInsets.fromLTRB(10, 10, bodyheight*0.25, 0),
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

                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print("1");
          String name1 = name.text;
          String catogary1 = catogary.text;
          String details1 = details.text;
          String price1 = price.text;

          if (name1.isEmpty) {
            setState(() {
              namestatus = true;
            });
          } else if (catogary1.isEmpty) {
            setState(() {
              catogarystatus = true;
            });
          } else if (details1.isEmpty) {
            setState(() {
              detailsstatus = true;
            });
          } else if (price1.isEmpty) {
            setState(() {
              pricestatus = true;
            });
          }
          else {
            print("2");
            for (i = 0; i < imagelist.length; i++) {

              if(imagelist[i].isNotEmpty)
                {
                  List<int> ii = File(imagelist[i]).readAsBytesSync();
                  imagepath[i] = base64Encode(ii);
                }
              else{
                print("Nothing.......");
              }

              

            }
            print("3");
            print("1==========${imagepath[0]}");
            print("2==========${imagepath[1]}");
            print("3==========${imagepath[2]}");


            String image1 = "";
            String image2 = "";
            String image3 = "";

            image1 = imagepath[0];
            image2 = imagepath[1];
            image3 = imagepath[2];
            print("4");

            Map productmap = {
              "id": userid,
              "names": name1,
              "category": catogary1,
              "description": details1,
              "prices": price1,
              "image1": image1,
              "image2": image2,
              "image3": image3,
            };

            print("okk");
            var url = Uri.parse(
                'https://priyadevani.000webhostapp.com/Apicalling/addproduct.php');
            var response = await http.post(url, body: productmap);
            print("virajjjjjjjjjjjj");
            print('Response status: ${response.statusCode}');
            print("mihirrrrrrrrrr");
            print('Response body: ${response.body}');

            var add = jsonDecode(response.body);

            addproduct_table aa = addproduct_table.fromJson(add);

            if (aa.connection == 1) // connection
            {
              if (aa.result == 1) // first time data store
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Add Product Sucessfully...")));
              } else if (aa.result == 2) {
                Fluttertoast.showToast(
                    msg: "Data....",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
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

  List<String> imagelist=List.filled(5, "");
  List<XFile>? images1=[];
  List imagepath =List.filled(5,"");
  int i = 0;


}

class addproduct_table {
  int? connection;
  int? result;

  addproduct_table({this.connection, this.result});

  addproduct_table.fromJson(Map<String, dynamic> json) {
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
