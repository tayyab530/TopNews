import 'dart:async';
import 'news-api-provider.dart';
import 'news-db-provider.dart';
import '../models/ItemModel.dart';

class Repository{
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = [
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async{
    return await sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    ItemModel item;
    var source;
    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null)
        break;
    }

    for(var cache in caches){
      if(cache != source )
      cache.addItem(item);
    }
    return item;
  }

  clearCaches() async{
    for(var cache in caches)
      await cache.clear();
  }
}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}