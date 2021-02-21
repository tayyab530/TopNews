import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesBlocProvider extends InheritedWidget{
  final StoriesBloc bloc;

  StoriesBlocProvider({Key key,Widget child})
  : bloc = StoriesBloc(),
    super(key: key, child: child);

  bool updateShouldNotify(_)=> true;
    
  static StoriesBloc of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<StoriesBlocProvider>().bloc;
  }
}