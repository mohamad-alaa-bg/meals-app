import 'package:flutter/material.dart';
import '../widgets/meal-item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';


class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-Meals';
  final List<Meal> availableMeals ;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  bool _loadedInitData = false ;
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) // هنا عندما يتم عمل حذف للصفحة بزر الرجوع ومن ثم عودة الدخول للصفحة يتم تنفيذ الكود من البداية وبالتالي تعود false وهو المطلوب
      {final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
      }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayMeals[index].id,
              title: displayMeals[index].title,
              imageUrl: displayMeals[index].imageUrl,
              affordability: displayMeals[index].affordability,
              complexity: displayMeals[index].complexity,
              duration: displayMeals[index].duration,
            );
          },
          itemCount: displayMeals.length,
        ));
  }
}
