import 'dart:convert';


import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thaliparamb_rozza/Api/ProductInfoApi.dart';


class ProductDetailPage extends StatefulWidget {
  var id;

  // static const routeName = "/property-sell";

  ProductDetailPage({Key key, this.id}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProductDetailPage> {

 var name ="";
 var star ="";
 var cat ="";
 var newprice ="";
 var oldprice ="";
 var disc ="";
 var color ="";
 var arrProdImages =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getProdDetails();
    setState(() {});
  }
  Future<String> getProdDetails() async {
    print("responseeeeeeeeeeee");
    var rsp = await getProductInfoApi(widget.id.toString());
    print("r444444444sp");
    print(rsp);
    if(rsp['status']==true){
      setState(() {

        name =rsp['product_info']['category_name'];

        star =rsp['product_info']['rating'];
        cat =rsp['product_info']['category_name'];
        newprice =rsp['product_info']['offer_price'];
        oldprice =rsp['product_info']['actual_price'];
        disc =rsp['product_info']['description'];

        color =rsp['product_info']['category_name'];
        disc =rsp['product_info']['category_name'];
      });

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: Builder(builder: (BuildContext context) {
        //   return Container(
        //     padding: EdgeInsets.only(right: 5),
        //     child: Image.asset(
        //       'images/logo.png',
        //       fit: BoxFit.contain,
        //       height: 32,
        //     ),
        //   );
        // }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

//            Container(
//                padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
          ],
        ),
        actions: <Widget>[
          //  Text("Chat with us"),
          // IconButton(
          //   icon: Icon(Icons.menu),
          //   color: Colors.grey,
          //   onPressed: () {},
          // ),
        ],
      ),
      body: Container(
          color: Colors.white,
          child:  ListView(
              children: <Widget>[
                banner(),
                howtoUse(),
                nameWid(),
                SizedBox(height: 5),

              ],
            ),
          ),

      // ,Builder(
      //   builder: (context) {
      //     return ListView(
      //       children: <Widget>[
      //
      //         ],
      //
      //     );
      //   },
      // ),
    );
  }

 void _productDescriptionModalBottomSheet(context) {

   showModalBottomSheet(

       context: context,
       builder: (BuildContext bc) {

         return Scaffold(
             resizeToAvoidBottomInset: true,
           body:  ListView(

             children: <Widget>[
               Container(
                 child: Container(
                   margin: EdgeInsets.all(5.0),
                   child: Column(

                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(right: 8, left: 5, top: 8, bottom: 8),
                         // decoration: BoxDecoration(
                         //     color: Colors.white,
                         //     borderRadius: BorderRadius.all(Radius.circular(16))),
                         child: Row(
                           children: <Widget>[

                             Expanded(
                               child: Container(
                                 margin: EdgeInsets.only(left: 2),
                                 child: Column(
                                   mainAxisSize: MainAxisSize.max,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Container(

                                       child:  Text(

                                         "Whats your rating ?",
                                         textAlign: TextAlign.start,
                                         style: TextStyle(color: Colors.black, fontSize: 15),
                                       ),
                                     ),
                                     SizedBox(height: 6),

                                     Container(
                                       margin: EdgeInsets.only(left: 0),
                                       alignment: Alignment.topLeft,
                                       child: FlutterRatingBar(
                                         initialRating: 5,
                                         itemSize: 25,
                                         itemCount: 5,
                                         fillColor: Colors.amber,
                                         borderColor: Colors.black12.withAlpha(50),
                                         allowHalfRating: true,
                                         // onRatingUpdate: (rating) {
                                         //   strProdRating = rating;
                                         //   print(strProdRating);
                                         // },
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               flex: 100,
                             ),
                           ],
                         ),
                       ),
                     SizedBox(height: 10),
                       Container(

                         margin: EdgeInsets.only(left: 8),
                         alignment: Alignment.centerLeft,
                         child: Text(

                           "What can we improve ?",
                           textAlign: TextAlign.start,
                           style: TextStyle(color: Colors.black, fontSize: 15),
                         ),
                       ),


                       SizedBox(height: 8),

                       Container(
                         margin: const EdgeInsets.all(8.0),
                         padding: const EdgeInsets.all(3.0),
                         height: 100.0,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: new TextField(
                           textAlign: TextAlign.start,
                          // controller: reviewcodeController,
                           decoration: new InputDecoration(
                             hintText: 'Write Your Product Experience!',
                             border: InputBorder.none,

                           ),
                         ),
                       ),

                       Container(
                           margin: EdgeInsets.all(8.0),
                           width: double.infinity,
                           child: RaisedButton(

                               child: Text(
                                 "POST",
                                 style: TextStyle(color: Colors.white, fontSize: 14),
                               ),
                               color:Colors.grey,
                               textColor: Colors.white,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(8))),
                               onPressed: ()async {



                               }

                           )
                       )
                     ],
                   ),
                 ),
               )
             ],
           ),
         );
       });
 }


  Widget banner(){
    return
      Container(
        height: 300,
        child:Carousel(
          boxFit: BoxFit.fill,
          images: [
            NetworkImage('https://www.rosacontactlens.com/uploads/banner_image/24-03-2021_07-19-54.jpg'),
            NetworkImage('https://www.rosacontactlens.com/uploads/banner_image/22-03-2021_08-37-13.jpg'),
            NetworkImage('https://www.rosacontactlens.com/uploads/banner_image/22-03-2021_08-37-29.jpg'),

          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 500),
          dotColor: Colors.red[50],
          dotSize: 4.0,
          indicatorBgPadding: 2.0,
        ),

      );

  }
  Widget howtoUse(){
    return GestureDetector(onTap: (){

    },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15, left: 50,right: 50),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.black,),
        height: 25,
        // width: 100,

        // margin: EdgeInsets.only(left: 48, right: 48),
        child: Text(
          "HOW TO USE",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
  Widget nameWid(){
    return Container(
    //  padding: EdgeInsets.all(8),



      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                name.toString(),
                style: TextStyle(color: Colors.black,fontSize: 20 ),
              ),
            ),

               SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  // padding: const EdgeInsets.only(
                  //     bottom: 4, right: 8, left: 8,top: 4),

               //   width: 200,
                  margin: EdgeInsets.only(left: 5),

                alignment: Alignment.topLeft,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      FlutterRatingBar(
                        initialRating: double.parse(star.toString()),
                        itemSize: 14,
                        itemCount: 5,
                        fillColor: Colors.amber,
                        borderColor: Colors.amber.withAlpha(50),
                        allowHalfRating: false,
                       // onRatingUpdate: (rating) {},
                      ),
                      SizedBox(width: 4),
             //         Text("1 Reviews"),





                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  margin: EdgeInsets.only(left: 5),
                    child: Text(cat,style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "\$"+newprice,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "\$"+oldprice,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                  disc,
                    style: TextStyle(fontSize: 14.0, height: 1.45),
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 5,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  // padding: const EdgeInsets.only(
                  //     bottom: 4, right: 8, left: 8,top: 4),

                  //   width: 200,
                  margin: EdgeInsets.only(left: 5),

                  alignment: Alignment.topLeft,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                      Text("Color:"),
                      GestureDetector(onTap: (){

                      },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), color: Colors.grey,),
                          height: 25,
                           width: 100,

                          // margin: EdgeInsets.only(left: 48, right: 48),
                          child: Text(
                            "Grey",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )





                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15, left: 50,right: 50,bottom: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.grey,),
                  height: 40,
                   width: double.infinity,

                  // margin: EdgeInsets.only(left: 48, right: 48),
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(top: 5.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Divider(
                        height: 1.0,
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Post Reviews',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _productDescriptionModalBottomSheet(context);
                        },
                      ),
                      Divider(
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),



          ],
        ),
      ),

      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,

          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(0))),
    );
  }







}
