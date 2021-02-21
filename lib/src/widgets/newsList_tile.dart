
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_api/src/widgets/loading_container.dart';
import '../models/ItemModel.dart';
import '../blocs/stories_bloc_provider.dart';

class NewsListTile extends StatelessWidget{
  final int itemID;

  NewsListTile({this.itemID});

  Widget build(context){
    final bloc = StoriesBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int,Future<ItemModel>>> snapshot){
        if(!snapshot.hasData)
          return LoadingContainer();
        
        return FutureBuilder(
          future: snapshot.data[itemID],
          builder: (context,AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData)
              return LoadingContainer();
            
            return buildTile( context, itemSnapshot.data );
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context,ItemModel item){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.grey,Colors.blueGrey[200]]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: (){
          Navigator.pushNamed(context, '/${item.id}');
        },
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('${item.score} Up Votes'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.comment),
            Text('${item.descendants}'),
            ],
          ),
      ),
    );
  }

}