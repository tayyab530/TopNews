import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{

  Widget build(context){
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(height: 8.0,thickness: 3.0,),
      ],
    );
  }

  Widget buildContainer(){
    return Container(
      color: Colors.grey[300],
      height: 25.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}