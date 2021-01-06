import 'package:flutter/material.dart';
import 'category.dart';
import 'wallpaper.dart' as wallpaper;
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}
class _CategoryListState extends State<CategoryList> {
  bool issearching=false;
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: !issearching ? Text( 'Search More') :
           TextField(
             style: TextStyle(color: Colors.white),
             decoration: InputDecoration(
                 hintText: "Search Wallpaper Here" ,
                     hintStyle: TextStyle(color: Colors.white),
             ),
             keyboardType: TextInputType.text,
             textInputAction: TextInputAction.search,
             autofocus: true,
             focusNode: _focusNode,
             controller: searchController,

           ),
              centerTitle: true,
              actions: <Widget>[
                        issearching ?
                IconButton(icon: Icon(Icons.check),
                    onPressed: (){
                   setState(() {
                    this.issearching =false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => wallpaper.Wallpaper( name:searchController.text ,)));
                   });
                    })
                            :  IconButton(icon: Icon(Icons.search),
                            onPressed: ()
                        {
                          setState(() {
                                this.issearching =true;
                          });
                        })

              ],
          ),
        body: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => wallpaper.Wallpaper(
                                name: categoryList[index].name)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: categoryList[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categoryList[index].name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ),
      );
    }
}
