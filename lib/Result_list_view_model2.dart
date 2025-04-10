
import 'package:flutter/cupertino.dart';
import 'package:haberuygulama/Result_view_model.dart';
import 'NewsService2.dart';

enum Status {initial,loading,loaded}
class ResultlistViewModel2 extends ChangeNotifier{
  ResultViewModel viewModel = ResultViewModel('general', []);
  Status status = Status.initial;
  ResultlistViewModel2() {
    getNews2('general');

  }
  Future<void>getNews2(String category) async{
    status=Status.loading;
    notifyListeners();
    viewModel.result = await NewService2().Habericek(category);
    status = Status.loaded;
    notifyListeners();




  }}