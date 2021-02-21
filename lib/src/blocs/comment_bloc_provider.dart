import 'package:flutter/material.dart';
import 'comment_bloc.dart';
export 'comment_bloc.dart';

class CommentBlocProvider extends InheritedWidget{
  final CommentBloc bloc; 

  CommentBlocProvider({Key key,Widget child})
    : bloc = CommentBloc(),
      super(key: key,child: child);

  bool updateShouldNotify(_) => true;

  static CommentBloc of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<CommentBlocProvider>().bloc);
  }
}