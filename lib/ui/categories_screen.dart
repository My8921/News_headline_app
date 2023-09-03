import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsandriodproject/Models/categories_news_model.dart';

import '../view_model/news_view_model.dart';

class categories extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> S1();

}

class S1 extends State<categories>{


  news_view_model viewModel=news_view_model();
  final format=DateFormat('MMMM dd, yyyy');

  String cateogory='General';

  List<String> cateogireslist=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',

  ];

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width *1;
    final height=MediaQuery.sizeOf(context).height *1;

    return Scaffold(

appBar: AppBar(

),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: cateogireslist.length,
                itemBuilder: (context,index){
return InkWell(
  onTap: (){
    cateogory=cateogireslist[index];
    setState(() {

    });
  },
  child:   Padding(

    padding: const EdgeInsets.only(right: 12),

    child:   Container(



      decoration: BoxDecoration(



        color: cateogory== cateogireslist[index]? Colors.blue : Colors.grey ,

        borderRadius: BorderRadius.circular(20),



      ),



      child: Center(child: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 12),

        child: Text(cateogireslist[index].toString(),style: GoogleFonts.poppins(

          fontSize: 13,
          color: Colors.white,
        ),),

      )),



    ),

  ),
);

            }),

            ),

           SizedBox(height: 50,),
            Expanded(
              child: FutureBuilder<newscategories>(
                future: news_view_model().fetchCategoriesNewsApi(cateogory),
                builder: (BuildContext context,snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }
                  else{
                    return ListView.builder(


                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder:(context,index)
                        {
                          DateTime? dateTime;

                          try{
                            dateTime=   DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());


                          }
                          catch(error)
                          {

                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom:15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),

                                  child: CachedNetworkImage(
                                   height: height *.18,
                                     width: width*.3,
                                    imageUrl:   snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context,url)=>Container(child: SpinKitCircle(
                                      size: 50,
                                      color: Colors.blue,
                                    ),),
                                    errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.red,),
                                  ),
                                ),
                                Expanded(child: 
                                
                                Container(height: height*.18,
                        padding: EdgeInsets.only(left:15)
                        ,
                              child: Column(
                                children: [
                                  Text(snapshot.data!.articles![index].title.toString()!='null' ? snapshot.data!.articles![index].title.toString():'Sorry No Response from Api for this News',
                                        maxLines: 3,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black54,
                               fontWeight: FontWeight.w700,

                                  ),

                                  ),
                                  Spacer(),

                                  Container(
                                    width: width * 0.8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text(

                                          snapshot.data!.articles![index].source!.name.toString().length >10 ?snapshot.data!.articles![index].source!.name.toString().substring(0,9):snapshot.data!.articles![index].source!.name.toString()  ,style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,

                                        ),),
                                         Text(
                                         dateTime != null ? format.format(dateTime!).toString() :'' , //

                                           overflow: TextOverflow.clip,// 'N/A' is used for null dates
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                         ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                                ),

                                ),


                              ],
                            ),
                            
                          );
                        }
                    );



                  }
                },


              ),
            )

          ],
        ),
      ),
    );

  }



}