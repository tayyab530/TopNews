import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/ItemModel.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache{
  Database db;

  Future<List<int>> fetchTopIds() {
    return null;
  }

  NewsDbProvider(){init();}

  void init() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path,"items2.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb,int version){
        newDb.execute("""
          CREATE TABLE items
          (
               id INTEGER PRIMARY KEY,
               deleted INTEGER,
               type TEXT,
               by TEXT,
               time INTERGER,
               text TEXT,
               dead INTERGER,
               parent INTEGER,
               kids BLOB,	
               url TEXT,	
               score INTERGER,	
               title TEXT,	
               descendants INTEGER

          )
        """);
      },
    );

  }

  Future<ItemModel> fetchItem(int id) async{
    final maps = await db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );


    if(maps.length > 0){
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item){
    return db.insert(
      "items",
      item.toMapforDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
      );
  }

  Future<int> clear(){
    return db.delete('items');
  }
}

final newsDbProvider = NewsDbProvider();