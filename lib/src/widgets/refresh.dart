import 'package:flutter/material.dart';
import 'package:news_api/src/blocs/stories_bloc_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({this.child});

  Widget build(context) {
    final bloc = StoriesBlocProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async{
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
