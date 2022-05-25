import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/editpage.dart';
import 'package:loginpage/homepage.dart';
import 'package:loginpage/splashscreen.dart';
import 'package:loginpage/view2page.dart';
import 'dart:developer' as developer;

class view1 extends StatefulWidget {
  const view1({Key? key}) : super(key: key);

  @override
  State<view1> createState() => _adddataState();
}

class _adddataState extends State<view1> {


  bool status = false;

  // List productid = [];
  // List image1 = [];
  // List image2 = [];
  // List image3 = [];
  // List name1 = [];
  // List catogary1 = [];
  // List details1 = [];
  // List price1 = [];
  // List discountprice = [];
  // int productlength = 0;

  View_Product? vvv;

  Map mapp = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myviewdata();
   
  }

  myviewdata() async {
    String userid = splash.pref!.getString("id") ?? "";

    print("objectjjjjjjjjjjjjjjj");

    mapp = {"id": userid};
    //userid getstring mathi ave

    var url = Uri.parse(
        'https://priyadevani.000webhostapp.com/Apicalling/addview.php');
    var response = await http.post(url, body: mapp);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    developer.log('Response body: ${response.body}');

    var viewdata1 = jsonDecode(response.body);
    setState(() {
      vvv = View_Product.fromJson(viewdata1);
      status=true;
    });

    //   setState(() {
    //     productlength = vvv.productdata!.length;
    //   });
    //
    //   for (int i = 0; i < productlength; i++) {
    //     productid.add(vvv.productdata![i].id);
    //     name1.add(vvv.productdata![i].productname);
    //     details1.add(vvv.productdata![i].description);
    //     price1.add(vvv.productdata![i].price);
    //     image1.add(vvv.productdata![i].image);
    //     image2.add(vvv.productdata![i].image2);
    //     image3.add(vvv.productdata![i].image3);
    //     discountprice.add(vvv.productdata![i].discountprice);
    //     catogary1.add(vvv.productdata![i].catogary);
    //   }
    // }
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
      body: status
          ? SingleChildScrollView(
              child: Container(
                height: bodyheight,
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
                                  color: Colors.black,
                                  width: bodyheight * 0.001)),
                        ),
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.85,
                      width: double.infinity,
                      // decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: ListView.builder(
                        itemCount: vvv!.productdata!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return view2(
                                    vvv!.productdata![index].image!,
                                    vvv!.productdata![index].image2!,
                                    vvv!.productdata![index].image3!,
                                    vvv!.productdata![index].productname!,
                                    vvv!.productdata![index].price!,
                                    vvv!.productdata![index].discountprice!,
                                    vvv!.productdata![index].description!,
                                    vvv!.productdata![index].catogary!,
                                    vvv!.productdata![index].id!,
                                    vvv!.productdata![index].userid!,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              height: bodyheight * 0.30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(width: bodyheight * 0.01)),
                              child: Row(
                                children: [
                                  Card(
                                    child: Container(
                                      height: bodyheight * 0.25,
                                      width: twidth * 0.30,
                                      margin: EdgeInsets.all(bodyheight * 0.01),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://priyadevani.000webhostapp.com/Apicalling/${vvv!.productdata![index].image}'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: bodyheight * 0.25,
                                      width: twidth * 0.50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "  ${details1[index]}",
                                          //   style: TextStyle(
                                          //       fontSize: bodyheight * 0.03,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          Text(
                                            "  ${vvv!.productdata![index].productname}",
                                            style: TextStyle(
                                              fontSize: bodyheight * 0.03,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "  ${vvv!.productdata![index].catogary}",
                                            style: TextStyle(
                                                fontSize: bodyheight * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "  ${vvv!.productdata![index].description}",
                                            style: TextStyle(
                                                fontSize: bodyheight * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: bodyheight * 0.04,
                                            width: twidth * 0.50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Rs.${vvv!.productdata![index].discountprice}/-",
                                                  style: TextStyle(
                                                      fontSize:
                                                          bodyheight * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${100 * (int.parse(vvv!.productdata![index].price.toString()) - int.parse(vvv!.productdata![index].discountprice.toString())) ~/ int.parse(vvv!.productdata![index].price.toString())}% off",
                                                  style: TextStyle(
                                                      fontSize:
                                                          bodyheight * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  "Rs.${vvv!.productdata![index].price}/-",
                                                  style: TextStyle(
                                                      fontSize:
                                                          bodyheight * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator(color: Colors.black,)),
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
  String? discountprice;

  Productdata(
      {this.id,
      this.userid,
      this.image,
      this.image2,
      this.image3,
      this.productname,
      this.catogary,
      this.description,
      this.price,
      this.discountprice});

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
    discountprice = json['discountprice'];
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
    data['discountprice'] = this.discountprice;
    return data;
  }
}

// class View_Product {
//   int? connection;
//   int? result;
//   List<Productdata>? productdata;
//
//   View_Product({this.connection, this.result, this.productdata});
//
//   View_Product.fromJson(Map<String, dynamic> json) {
//     connection = json['connection'];
//     result = json['result'];
//     if (json['productdata'] != null) {
//       productdata = <Productdata>[];
//       json['productdata'].forEach((v) {
//         productdata!.add(new Productdata.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['connection'] = this.connection;
//     data['result'] = this.result;
//     if (this.productdata != null) {
//       data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Productdata {
//   String? id;
//   String? userid;
//   String? image;
//   String? image2;
//   String? image3;
//   String? productname;
//   String? catogary;
//   String? description;
//   String? price;
//
//   Productdata(
//       {this.id,
//       this.userid,
//       this.image,
//       this.image2,
//       this.image3,
//       this.productname,
//       this.catogary,
//       this.description,
//       this.price});
//
//   Productdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userid = json['userid'];
//     image = json['image'];
//     image2 = json['image2'];
//     image3 = json['image3'];
//     productname = json['productname'];
//     catogary = json['catogary'];
//     description = json['description'];
//     price = json['price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userid'] = this.userid;
//     data['image'] = this.image;
//     data['image2'] = this.image2;
//     data['image3'] = this.image3;
//     data['productname'] = this.productname;
//     data['catogary'] = this.catogary;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     return data;
//   }
// }
