import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/component/article.dart';
import 'package:news_app/component/category.dart';
import 'package:news_app/component/drawer.dart';
import 'package:news_app/data/api.dart';
import 'package:news_app/data/categoryData.dart';
import 'package:news_app/model/categoryModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  static bool _light = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    TopHeadlines.getNews();
  }

  static ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  static ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _light ? _darkTheme : _lightTheme,
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text(
            'FNewsNetwork',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrangeAccent,
            ),
          ),
          centerTitle: true,
          backgroundColor: _light ? Colors.black12 : Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.deepOrangeAccent,
          ),
          actions: [
            Switch(
                activeColor: Colors.deepOrangeAccent,
                value: _light,
                onChanged: (state) {
                  setState(() {
                    _light = state;
                  });
                }),
          ],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Top News',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10),
                        itemCount: TopHeadlines.topHeadlines.length,
                        itemBuilder: (context, index) {
                          return Article(
                            title: TopHeadlines.topHeadlines[index].title,
                            description:
                                TopHeadlines.topHeadlines[index].description,
                            url: TopHeadlines.topHeadlines[index].url,
                            urlToImage:
                                TopHeadlines.topHeadlines[index].urlToImage,
                          );
                        }),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: _light ?  Colors.grey.shade800 : Colors.white,
              ),
              height: 70,
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Category(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
