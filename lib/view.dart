import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/homepage.dart';
import 'package:loginpage/splashscreen.dart';

class view1 extends StatefulWidget {
  const view1({Key? key}) : super(key: key);

  @override
  State<view1> createState() => _adddataState();
}

class _adddataState extends State<view1> {
  String? id;
  String? userid;
  String? image;
  String? image2;
  String? image3;
  String? productname;
  String? catogary;
  String? description;
  String? price;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myviewdata();
    view();
  }



  void view() {
    image = splash.pref!.getString("idd") ?? "";
    image = splash.pref!.getString("image1") ?? "";
    image = splash.pref!.getString("image2") ?? "";
    image = splash.pref!.getString("image3") ?? "";
    image = splash.pref!.getString("productname") ?? "";
    image = splash.pref!.getString("catogary") ?? "";
    image = splash.pref!.getString("description") ?? "";
    image = splash.pref!.getString("price") ?? "";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight =
        theight - navibartheight - statusbarheight - appbarheight;
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      // backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: bodyheight * 0.08,
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
              height: bodyheight * 0.85,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        height: bodyheight * 0.45,
                        width: twidth * 0.44,
                        padding: EdgeInsets.all(bodyheight*0.001),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          image: DecorationImage(
                              image: FileImage(File("")), fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        height: bodyheight * 0.45,
                        width: twidth * 0.55,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Column(
                          children: [
                            Text(
                              "${productname}",
                              style: TextStyle(
                                  fontSize: bodyheight * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),Text(
                              "${description}",
                              style: TextStyle(
                                  fontSize: bodyheight * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),Text(
                              "${price}",
                              style: TextStyle(
                                  fontSize: bodyheight * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return home1();
            },
          ));
        },
      ),
    );
  }

  TextEditingController search = TextEditingController();
}

Future<void> myviewdata() async {

  String? id;
  String? userid;
  String? image;
  String? image2;
  String? image3;
  String? productname;
  String? catogary;
  String? description;
  String? price;


  Map mapp ={
    "id" : id,
    "loginid":userid,
    "image1":image,
    "image2":image2,
    "image3":image3,
    "productname":productname,
    "cato": catogary,
    "descri":description,
    "price":price
  };

  var url = Uri.parse(
      'https://priyadevani.000webhostapp.com/Apicalling/addproduct.php');
  var response = await http.post(url, body: mapp);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  var viewdata1 = jsonDecode(response.body);
  View_Product vvv = View_Product.fromJson(viewdata1);

    String? id2=vvv.productdata![0].id;
    String? userid2=vvv.productdata![0].userid;
    String? image12=vvv.productdata![0].image;
    String? image22=vvv.productdata![0].image2;
    String? image32=vvv.productdata![0].image3;
    String? productname2=vvv.productdata![0].productname;
    String? catogary2=vvv.productdata![0].catogary;
    String? description2=vvv.productdata![0].description;
    String? price2=vvv.productdata![0].price;

    splash.pref!.setString("idd",id2!);
    splash.pref!.setString("loginid",userid2!);
    splash.pref!.setString("image1",image12!);
    splash.pref!.setString("image2",image22!);
    splash.pref!.setString("image3",image32!);
    splash.pref!.setString("productname",productname2!);
    splash.pref!.setString("catogary",catogary2!);
    splash.pref!.setString("description",description2!);
    splash.pref!.setString("price",price2!);


}

class View_Product {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  View_Product({this.connection, this.result, this.productdata});

  View_Product.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? userid;
  String? image;
  String? image2;
  String? image3;
  String? productname;
  String? catogary;
  String? description;
  String? price;

  Productdata(
      {this.id,
        this.userid,
        this.image,
        this.image2,
        this.image3,
        this.productname,
        this.catogary,
        this.description,
        this.price});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    image = json['image'];
    image2 = json['image2'];
    image3 = json['image3'];
    productname = json['productname'];
    catogary = json['catogary'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['image'] = this.image;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['productname'] = this.productname;
    data['catogary'] = this.catogary;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}
