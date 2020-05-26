import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  // هنا استخدمنا ال initstate لان ال widget.name لايمكن استخدامها في المتغيرات وبالتالي
  // لم نستطيع استخدامها في تعريف المتغير pages لذلك قمنا بوضعها هنا
  // وبشكل عام لا يمكن اسناد قيمة متغير لمتغير جديد عند تعريفه
  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Your Favorites'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            //  backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );

    //to add tab into appBar
//    return DefaultTabController(
//      length: 2,
//      //initialIndex: 0,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text('Meals'),
//          bottom: TabBar(
//            tabs: <Widget>[
//              Tab(
//                icon: Icon(Icons.category),
//                text: 'Categories',
//              ),
//              Tab(
//                icon: Icon(Icons.star),
//                text: 'Favorites',
//              ),
//            ],
//          ),
//        ),
//          body:TabBarView(children: <Widget>[
//            CategoriesScreen(),
//            FavoritesScreen(),
//          ],) ,
//      ),
//    );
  }
}
