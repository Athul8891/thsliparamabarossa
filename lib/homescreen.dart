import 'dart:convert';


import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thaliparamb_rozza/Api/AllFavApi.dart';
import 'package:thaliparamb_rozza/Api/BannerApi.dart';
import 'package:thaliparamb_rozza/Api/LatestApi.dart';
import 'package:thaliparamb_rozza/Api/TrendingApi.dart';
import 'package:thaliparamb_rozza/Api/networkutils.dart';
import 'package:thaliparamb_rozza/productdetails.dart';
import 'package:thaliparamb_rozza/webview.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 var catList =["Trending Now","Latest Arrivals","All Time Favorite"];
 TabController Tabcontroller;
 var arrBanner = null;
 var arrImages = [];
 List arrProducts = null;


 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
     this.getBanner();
     this.getTending();

    setState(() {});
  }

 Future<String> getBanner() async {
   print("responseeeeeeeeeeee");
   var rsp = await getBannerApi();
   print("responseeeeeeeeeeee");
   if(rsp['status']==true){
     print("ith wrk avnd");
     arrBanner =rsp['result'];
     print(arrBanner);
     if (arrBanner != null) {
       for (var value in arrBanner) {
         if (value['banner_image'] != null) {
           final name = value['banner_image'];
           setState(() {
             arrImages.add(NetworkImage(bannerBaseUrl + name));

           });
         }

         print("arrImagesssssssssssssss");
         print(arrImages);
       }
     }
   }
   print(rsp);
 }

 Future<String> getTending() async {
   var rsp = await getTrendingApi();
   if(rsp['status']==true){
     setState(() {
       arrProducts=rsp['result'];

     });
   }
   print("responseeeeeeeeeeee");
   print(arrProducts);
 }

 Future<String> getLatest() async {
   var rsp = await getLatestApi();
   if(rsp['status']==true){
     setState(() {
       arrProducts=rsp['result'];

     });

   }
   print("responseeeeeeeeeeee");}

 Future<String> getAllFavList() async {
   var rsp = await getFavApi();
   if(rsp['status']==true){
     setState(() {
       arrProducts=rsp['result'];

     });

   }
   print("responseeeeeeeeeeee");}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      key: _scaffoldKey,
      endDrawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      _createDrawerHeader(),
      _createDrawerItem(
          icon: Icons.home,
          text: 'Colored Lens',
          onTap:  null),
      _createDrawerItem(
          icon: Icons.account_circle,
          text: 'Daily Contact',
          onTap:null),
      _createDrawerItem(
          icon: Icons.favorite_border,
          text: 'Solutions',
          onTap:null),
      // _createDrawerItem(
      //     icon: Icons.call,
      //     text: 'Contact Us',
      //     onTap:null),
    ],
  ),
),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(left: 8),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 50,
            ),
          );
        }),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

//            Container(
//                padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
          ],
        ),
        actions: <Widget>[
        //  Text("Chat with us"),
          IconButton(
            icon: Icon(Icons.menu),
            color: Colors.grey,
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      body: Container(
          color: Colors.white,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: ListView(
              children: <Widget>[
                  banner(),
                _tabSection(context),
                gridList()
              ],
            ),
          )),

    );
  }

Widget banner(){
    return
      Container(
        height: 170,
        child: Carousel(
          images: arrImages.length != 0
              ? arrImages
              : [AssetImage("images/logo.png")],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Color(0xFFEF6862),
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.purple.withOpacity(0.0),
          boxFit: BoxFit.cover,
          animationCurve: Curves.fastOutSlowIn,
        ),

      );

}

Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: catList.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
               indicatorColor: Colors.grey,
              onTap: (index){
                 if(index==0){
                   getTending();
                 }
                 if(index==1){
                   getLatest();
                 }
                 if(index==2){
                   getAllFavList();
                 }

                print(index);
              },
              controller: Tabcontroller ,
              tabs: List<Widget>.generate(
                catList.length,
                    (int index) {

                  return Container(

                    child: new Tab(


                      child: Text(catList[index].toString(),style: TextStyle(color: Colors.grey,fontSize: 12),maxLines: 1,),
                    ),
                  );
                },
              ),

            ),
          ),
          // Container(
          //   //Add this to give height
          //   height: MediaQuery.of(context).size.height,
          //   child: TabBarView(children: [
          //
          //
          //
          //   ]),
          // ),
        ],
      ),
    );
  }

  Widget gridList(){
   return  Container(
     color: Colors.grey.shade100,
     child: GridView.builder(
       physics: NeverScrollableScrollPhysics(),
       shrinkWrap: true,
       primary: false,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2, childAspectRatio: 0.68),
       itemCount: arrProducts != null ? arrProducts.length : 0,
       itemBuilder: (context, index) {
         final item  = arrProducts != null ? arrProducts[index] : null;
         return gridItem(item,context, index);
       },

     ),
     margin: EdgeInsets.only(bottom: 8, left: 4, right: 4, top: 8),
   );
  }

 gridItem(var item,BuildContext context, int index) {
   return GestureDetector(
     onTap: () {
       Navigator.of(context).push(new MaterialPageRoute(
           builder: (context) =>
               WebPage(id: item['pid'],)));
     },
     child: Container(
       decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.all(Radius.circular(6)),
           border: Border.all(color: Colors.grey.shade200)),
      // padding: EdgeInsets.only( top: 5),
       margin: EdgeInsets.all(8),
       child: Column(
         children: <Widget>[

           Image(
             image: NetworkImage(imageBaseUrl+item['image'].toString()),
             height: 140,
             fit: BoxFit.contain,
           ),
           Container(
             margin: EdgeInsets.only(top: 5),
             child: Column(
               children: <Widget>[
                 Container(
                   child: Text(
                     item['category_name'].toString(),
                     style: TextStyle(fontSize: 12),
                     textAlign: TextAlign.center,
                   ),
                   alignment: Alignment.center,
                 ),
                 SizedBox(height: 4),
            FlutterRatingBar(
         initialRating:item['rating']!=null? double.parse(item['rating'].toString()):0,
         itemSize: 14,
         itemCount: 5,
         fillColor: Colors.amber,
         borderColor: Colors.amber.withAlpha(50),
        // allowHalfRating: true,

       //  onRatingUpdate: (rating) {},
       ),
                 SizedBox(height: 4),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text(
                       "AED"+item['offer_price'].toString(),
                       style: TextStyle(color: Colors.black, fontSize: 14),
                     ),
                    SizedBox(width: 8),
                     Text(
                       "AED"+item['actual_price'].toString(),
                       style: TextStyle(
                           color: Colors.grey,
                           fontSize: 14,
                           decoration: TextDecoration.lineThrough),
                     ),
                   ],
                 ),
                 //SizedBox(height: 6),

               ],
             ),
           ),
           Container(
             margin: EdgeInsets.only(top: 5),
             height: 25,
             width: 70,
            // margin: EdgeInsets.only(left: 48, right: 48),
             child: RaisedButton(
               color: Colors.black,
               textColor: Colors.white,
               onPressed: () {
                 ConfirmOnline();
               },
               child: Text(
                 "TRY",
                 style: TextStyle(color: Colors.white, fontSize: 14),
               ),
             ),
           )
         ],
       ),
     ),
   );
 }

 ConfirmOnline() {
   return showModalBottomSheet(
       shape: RoundedRectangleBorder(

         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
       ),
       backgroundColor: Colors.white,
       context: context,
       isScrollControlled: true,
       builder: (context) => Stack(children: [
         Column(
           // mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             Container(
                 alignment: Alignment.centerLeft,


                 child: Padding(
                   padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                   child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      // Spacer(),
                       Text(
                         "Try on",
                         style: TextStyle(
                             fontWeight: FontWeight.w700, fontSize: 20,color: Colors.white),
                       ),
                       Spacer(),
                       IconButton(
                           icon: Icon(Icons.close), onPressed: () {
                             Navigator.pop(context);
                       })
                     ],
                   ),
                 ),
                 height: 60,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.blue,
                   borderRadius:
                   BorderRadius.vertical(top: Radius.circular(20.0)),
                 )),
             Divider(),
             Text(
               "Move your face",
               style: TextStyle(
                 color: Colors.grey,
                 fontSize: 16,
               ),
             ),
             SizedBox(
               height: 8.0,
             ),
             Container(
               padding: EdgeInsets.only(right: 5),
               child: Image.asset(
                 'images/img.jpg',
                 fit: BoxFit.contain,
              //   height: 32,
               ),
             ),
             Padding(
               padding: EdgeInsets.only(
                 //  bottom: MediaQuery.of(context).viewInsets.bottom,
                   top: 10),
             ),
             SizedBox(height: 6),
             Text(
               "LENSES",

               style:TextStyle(
                   color: Colors.black.withOpacity(.5), fontSize: 11,fontWeight: FontWeight.bold),
               textAlign: TextAlign.left,
             ),
             SizedBox(height: 6),
             ConstrainedBox(
               constraints: BoxConstraints(maxHeight: 60),
               child: ListView.builder(
                 itemBuilder: (context, index) {
                   return recentSearchListViewItem( index);
                 },
                 itemCount: 15,
                 primary: false,
                 scrollDirection: Axis.horizontal,
               ),
             ),
           ],
         ),
       ]));
 }
 recentSearchListViewItem( int index) {
   double leftMargin = 8;
   double rightMargin = 8;
   if (index == 0) {
     leftMargin = 16;
   }
   if (index == 15 - 1) {
     rightMargin = 16;
   }
   return Container(
     margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
     child: Column(
       children: <Widget>[
         Container(
           width: 40,
           height: 40,
           decoration: BoxDecoration(
               image: DecorationImage(
                   image: AssetImage("images/download.jpg"), fit: BoxFit.cover),
               border: Border.all(color: Colors.grey.shade300, width: 1),
               shape: BoxShape.rectangle),
         ),
         SizedBox(height: 4),
         Text(
           "Try",
           overflow: TextOverflow.ellipsis,
           textWidthBasis: TextWidthBasis.parent,
           softWrap: true,
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 10, color: Colors.black),
         )
       ],
     ),
   );
 }

 Widget _createDrawerHeader() {
   return DrawerHeader(
       margin: EdgeInsets.zero,
       padding: EdgeInsets.zero,
       child: Stack(children: <Widget>[
         Container(
           color: Colors.white,
           padding: EdgeInsets.all(20),
           child: Center(
             child: Image.asset(
               'images/logo.png',
               width: 130,
               height: 130,
             ),
           ),
         ),
       ]));
 }

 Widget _createDrawerItem(
     {IconData icon, String text, GestureTapCallback onTap}) {
   return ListTile(
     title: Row(
       children: <Widget>[
         Icon(
           icon,
           color: Color(0xFF808080),

         ),
         Padding(
           padding: EdgeInsets.only(left: 15.0),
           child: Text(
             text,
             style: TextStyle(color: Color(0xFF484848), fontFamily: 'Gilroy'),
           ),
         )
       ],
     ),
     onTap: onTap,
   );
 }


}
