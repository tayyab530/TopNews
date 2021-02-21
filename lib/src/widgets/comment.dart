import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_api/src/widgets/loading_container.dart';
import '../models/ItemModel.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final double depth;

  Comment({this.itemId, this.itemMap,this.depth});

  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return LoadingContainer();
        
        final item = snapshot.data;

        final children = [
          ListTile(
            contentPadding: EdgeInsets.only(left: depth * 16.0, right: 16.0),
            title: Container(margin: EdgeInsets.all(7.0),child: buildText(item)),
            subtitle: Container(margin: EdgeInsets.all(7.0),child: item.by == null? Text('Deleted!') :Text(item.by)),
          ),
          Divider(thickness: 2.0,),
        ];
        
        item.kids.forEach(
          (kidId) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            );
          },
        );

        return Column(
          children: children.cast<Widget>(),
        );
      },
    );
  }

  Widget buildText(ItemModel item){
    String text = item.text.replaceAll('&#x27;', "'");
    text = text.replaceAll('<p>', "\n\n");
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#x2F;', ',');
    
    return Text(text);
  }

}
