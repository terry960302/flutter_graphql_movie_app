import 'package:flutter/material.dart';
import 'package:flutter_graphql_test/UI/detail_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MainPage extends StatelessWidget {

  void onClickMovie(BuildContext context, Map _item){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(item: _item,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text("Graphql 테스트"),
      ),
      body: Query(
        options: QueryOptions(
          document: r"""query{
                          movies(rating: 8.5){
                            id
                            title
                            rating
                            summary
                            medium_cover_image
                          }
                        }""",
//          variables: <String, dynamic>{
//
//          }
        ),
        builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}){
          if(result.errors != null){
            return Center(child: Text("에러가 발생했습니다.\n${result.errors.toString()}"));
          }
          if(result.loading){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            print(result.data.toString());
            return _buildList(context, result);
          }
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, QueryResult result){
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: result.data["movies"].length,
        itemBuilder: (context, index){
          Map item = result.data["movies"][index];
          return Card(
            shape: StadiumBorder(),
            elevation: 20,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: ()=> onClickMovie(context, item),
                dense: true,
                leading: Image.network(item["medium_cover_image"]),
                title: Text(item["title"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                subtitle: Row(children: <Widget>[
                  Icon(Icons.star, color: Colors.yellow,),
                  Text(item["rating"].toString(), style: TextStyle(color: Colors.yellow),)
                ],),
                trailing: Text("Id\n${item["id"]}"),
              ),
            ),
          );
        });
  }
}