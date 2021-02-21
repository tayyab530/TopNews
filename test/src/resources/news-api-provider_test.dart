import 'package:news_api/src/resources/news-api-provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';


void main(){
  // test('FetchTopIds', () async {
  //   final apiProvider = ApiProvider();

  //   apiProvider.client = MockClient((response) async {
  //     return Response(json.encode([1,2,3,4]), 200);
  //   });
  //    final ids = await apiProvider.fetchTopIds(); 

  //    expect(ids, [1,2,3,4]);
  // });

  test('FetchItems', () async {
    final apiProvider = NewsApiProvider();

    apiProvider.client = MockClient((response) async {
      return Response(json.encode({"id": 1,"title": "ToYo"}), 200);
    });
     final items = await apiProvider.fetchItem(123); 

     expect(items.title,'ToYo');
     expect(items.id,1);
  });
}

