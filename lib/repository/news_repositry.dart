

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsandriodproject/Models/categories_news_model.dart';
import 'package:newsandriodproject/Models/news_chanel_headline_model.dart';

class news_repositry{

  //future function is used
Future<NewsChanelHeadlinesModel> fetchnewschanelHeadlineApi(String channelName)async{

String url='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=6997ca115af94c1db26dedc98bce793c';
//hitting the api
final response= await http.get(Uri.parse(url));

if(response.statusCode==200){

  //if ok then for parsing the data to json to dart we use newschanel headlines
  // model the data goes into newschanel headline model
  final body=jsonDecode(response.body);

  return NewsChanelHeadlinesModel.fromJson(body);
}
throw Exception('Error');
}


//categories

Future<newscategories> fetchCategoriesNewsApi(String categories)async{

  String url='https://newsapi.org/v2/everything?q=${categories}&apiKey=6997ca115af94c1db26dedc98bce793c';
//hitting the api
  final response= await http.get(Uri.parse(url));

  if(response.statusCode==200){

    //if ok then for parsing the data to json to dart we use newschanel headlines
    // model the data goes into newschanel headline model
    final body=jsonDecode(response.body);

    return newscategories.fromJson(body);
  }
  throw Exception('Error');
}


















}