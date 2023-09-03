
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsandriodproject/Models/news_chanel_headline_model.dart';
import 'package:newsandriodproject/ui/categories_screen.dart';
import 'package:newsandriodproject/view_model/news_view_model.dart';

import '../Models/categories_news_model.dart';
class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}
enum Filterlist {bbcNews,independent,reuters,cnn,Al_jazeera,Ary}



class _homeScreenState extends State<homeScreen> {
  String name='abc-news';

  news_view_model viewModel=news_view_model();
  final format=DateFormat('MMMM dd, yyyy');
  Filterlist? selectedmenu;

  @override



  Widget build(BuildContext context) {


    final width=MediaQuery.sizeOf(context).width *1;
    final height=MediaQuery.sizeOf(context).height*1;



    return Scaffold(
     appBar: AppBar(
       leading:IconButton(
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>categories()));


         },
         icon: Image.asset('images/category_icon.png',
         height: 30,
           width: 30,
         ),
       ),
       actions: [
PopupMenuButton<Filterlist>(
    initialValue: selectedmenu,
    onSelected: (Filterlist item){
      if(Filterlist.bbcNews.name==item.name){
name='bbc-news';
      }

      if(Filterlist.Ary.name==item.name){
        name='ary-news';
      }

      if(Filterlist.Al_jazeera.name==item.name){
        name='al-jazeera-english';
      }





setState(() {
  selectedmenu=item;

});



    },
    icon:Icon(Icons.more_vert,color: Colors.black,),
    itemBuilder:(context)=> <PopupMenuEntry<Filterlist>>[
  PopupMenuItem<Filterlist>(
value: Filterlist.bbcNews,
    child: Text('BBC News'),

  ),
      PopupMenuItem<Filterlist>(
        value: Filterlist.Al_jazeera,
        child: Text('Al_jazeera'),

      ),
      PopupMenuItem<Filterlist>(
        value: Filterlist.Ary,
        child: Text('Ary News'),

      ),
] )
       ],
       title: Text('News',style: GoogleFonts.poppins(fontSize: 24,fontWeight:FontWeight.w700),),
    centerTitle: true,
     ),
      body: ListView(
        children: [
Container(height: height*.5,
width: width,

 child: FutureBuilder<NewsChanelHeadlinesModel>(

   future: news_view_model().fetchnewschanelHeadlineApi(name),
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
return snapshot.data==null? Center(
  child:   Container(
    color:Colors.red,
    child: Text('Make Sure you have an Active internet Connection'),
  ),
) :ListView.builder(

scrollDirection: Axis.horizontal,
  itemCount: snapshot.data!.totalResults,
    itemBuilder:(context,index)
{

  DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());

  return SizedBox(
    child: Stack(

      alignment: Alignment.center,

      children: [
        Container(

          height: height * 0.6,
          width:  width * 0.9,
padding: EdgeInsets.symmetric(
  horizontal: height * .02,
),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),

            child: CachedNetworkImage(

              imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
              fit: BoxFit.cover,
placeholder: (context,url)=>Container(child: spinkit2,),
              errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.red,),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),),
            child: Container(
              padding: EdgeInsets.all(15),
alignment: Alignment.bottomCenter,
              height: height *0.22,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    width: width*0.7,
                    child: Text(snapshot.data!.articles![index].title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700)

                    ),

                  ),
                  Spacer(),
                  Container(
                    width: width * 0.7,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
     Text(snapshot.data!.articles![index].source!.name.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.w600)

    ),
     Text(format.format(dateTime),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500)

    ),
  ],
),
                  )
                ],
              ),

            ),
          ),
        )

      ],
    ),
  );
}
);



     }
   },


 ),



),

          Padding(
            padding: const EdgeInsets.all(12.0),

            child: FutureBuilder<newscategories>(

              future: news_view_model().fetchCategoriesNewsApi('General'),
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



                  return snapshot.data==null ? Container(
                    child: Text(''),

                  ) : ListView.builder(
shrinkWrap: true,

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
    );
  }


}

const spinkit2=SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);