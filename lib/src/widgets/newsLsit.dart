import 'package:news_api/src/widgets/newsList_tile.dart';
import 'package:news_api/src/widgets/refresh.dart';

import '../blocs/stories_bloc_provider.dart';

import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesBlocProvider.of(context);
    // Bad CHoice!!!!!!
    
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Top News!'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context,AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: LinearProgressIndicator(),
          );
        else
          return Refresh(
            child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              bloc.fetchItem(snapshot.data[index]);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.5),
                child: Column(
                  children: [
                    NewsListTile(itemID: snapshot.data[index]),
                    Container(margin: EdgeInsets.only(bottom: 3),),
                    Divider(height: 8.0,thickness: 3.0,),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}













// //For Parctice
  // Widget showDetails(int id,StoriesBloc bloc){
  //   return FutureBuilder(
  //     future: bloc.fetchItem(id),
  //     builder: (context,snapshot){
  //           return StreamBuilder(
  //         stream: bloc.item,
  //         builder: (context,AsyncSnapshot<ItemModel> snapshot){
  //           if(!snapshot.hasData)
  //             return Text('Fetching models....');
  //           return Container(
  //             child: Column(
  //               children: [
  //                 Text('${snapshot.data.title}'),
  //                 Container(margin: EdgeInsets.all(5.0),),
  //                 Text('${snapshot.data.type}'),
  //               ],
  //             ),
  //           );
  //         },
  //        );
  //       },
  //     );
  // }
