import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/ItemModel.dart';


class CommentBloc {
  final _commentFetcher = PublishSubject<int>();
  final _commentOutput = BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _repository  = Repository();

  //streams
  Stream<Map<int,Future<ItemModel>>> get itemWithComment => _commentOutput.stream;

  //sink
  Function(int) get fetchItemWithComments => _commentFetcher.sink.add;

  CommentBloc(){
    _commentFetcher.stream.transform(_commentTransformer()).pipe(_commentOutput);
  }

  _commentTransformer(){
    return ScanStreamTransformer< int, Map<int , Future<ItemModel>>>(
      (cache,int id,index){
        print(index);
        cache[id] = _repository.fetchItem(id);
        cache[id].then(
          (ItemModel item){
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));
          });
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }

  dispose(){
    _commentFetcher.close();
    _commentOutput.close();
  }
}