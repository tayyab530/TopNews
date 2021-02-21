import 'package:flutter/material.dart';
import '../screens/news_details.dart';
import 'newsLsit.dart';
import '../blocs/stories_bloc_provider.dart';
import '../blocs/comment_bloc_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentBlocProvider(
      child: StoriesBlocProvider(
        child: MaterialApp(
          title: "News",
          onGenerateRoute: routes,
        ),
      )
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/')
      return MaterialPageRoute(
        builder: (context) {
          final StoriesBloc bloc = StoriesBlocProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        },
      );
    else
      return MaterialPageRoute(
        builder: (context){
          final commentsBloc = CommentBlocProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemID: itemId,
          );
        });
  }
}
