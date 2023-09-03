import 'package:newsandriodproject/Models/categories_news_model.dart';
import 'package:newsandriodproject/Models/news_chanel_headline_model.dart';
import 'package:newsandriodproject/repository/news_repositry.dart';

class news_view_model{

  //hitting the api and returning the parse data calling the newsrepositry
  // from this class
final _repo=news_repositry();

Future<NewsChanelHeadlinesModel>fetchnewschanelHeadlineApi(String channelName) async{

  final response=await _repo.fetchnewschanelHeadlineApi(channelName);
//returning the reponse that we are going to put this data into over frontend;
  return response;

}


Future<newscategories>fetchCategoriesNewsApi(String categories) async{

  final response=await _repo.fetchCategoriesNewsApi(categories);
//returning the reponse that we are going to put this data into over frontend;
  return response;

}







}