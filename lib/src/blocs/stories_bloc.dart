import 'package:rxdart/rxdart.dart';
import '../models/ItemModel.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc{

  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();
  final _itemOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemFetcher = PublishSubject<int>();

  
  //For streams
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int,Future<ItemModel>>> get items => _itemOutput.stream;

  //For sinks
  Function(int) get fetchItem => _itemFetcher.sink.add;

  StoriesBloc(){
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemOutput);
  }

  fetchTopIds() async{
    List<int> ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache(){
    return _repository.clearCaches();
  }

  _itemTransformer(){
    return ScanStreamTransformer(
      (Map<int , Future<ItemModel>>cache,int id,_){  ///_ = index that we dont care right row
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int , Future<ItemModel> >{},
    );
  }

  


  // // //For Practice
  // fetchItem(id) async{
  //   ItemModel item = await _repository.fetchItem(id);
  //   _item.sink.add(item);
  // }
  // // For Practice
  // final _item = PublishSubject<ItemModel>();
  // Stream<ItemModel> get item => _item.stream;


  dispose(){
    _topIds.close();
    _itemOutput.close();
    _itemFetcher.close();
  }
}