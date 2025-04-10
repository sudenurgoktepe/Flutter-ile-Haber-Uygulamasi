import 'package:haberuygulama/Result_view_model.dart';
import 'package:haberuygulama/NewsService.dart';
import 'package:flutter/cupertino.dart';



enum Status {initial,loading,loaded}
class ResultlistViewModel extends ChangeNotifier{
  ResultViewModel viewModel = ResultViewModel('general', []);
  Status status = Status.initial;
  ResultlistViewModel(){
    getNews('general');

  }


  Future<void>getNews(String category) async{
    status=Status.loading;
    notifyListeners();
    viewModel.result = await NewsService().fetchNews(category);
    status = Status.loaded;
    notifyListeners();




  }




}