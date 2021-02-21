import 'package:flutter/material.dart';
import 'package:news_api/src/blocs/comment_bloc.dart';
import 'package:news_api/src/blocs/comment_bloc_provider.dart';
import 'package:news_api/src/models/ItemModel.dart';
import 'package:news_api/src/widgets/comment.dart';
import 'package:news_api/src/widgets/loading_container.dart';

class NewsDetail extends StatelessWidget{
  final int itemID;

  NewsDetail({this.itemID});

  Widget build(context){
    final CommentBloc bloc = CommentBlocProvider.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [Colors.grey[400],Colors.blueGrey],radius: 0.5),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text('Details'),
        ),
        body: buildBody(bloc),
      ),
    );
  }


  Widget buildBody(CommentBloc bloc){
    return StreamBuilder(
      stream: bloc.itemWithComment,
      builder: (context,AsyncSnapshot<Map<int , Future<ItemModel>>> snapshot){
        if(!snapshot.hasData)
          return LoadingContainer();

        final itemFuture = snapshot.data[itemID];

        return FutureBuilder(
          future: itemFuture,
          builder: (cotnext, AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData)
              return LoadingContainer();

            return buildList(snapshot.data,itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(Map<int,Future<ItemModel>> itemMap,ItemModel item){
    final children = [];

    children.add(buildTitle(item));

    final comments = item.kids.map(
      (kidsId) => Comment(itemId: kidsId,itemMap: itemMap,depth: 1,)).toList();

    children.addAll(comments);

    return ListView(
      children: children.cast<Widget>(),
    );
  } 

  Widget buildTitle(ItemModel item){
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}