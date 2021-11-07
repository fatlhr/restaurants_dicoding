import 'package:flutter/material.dart';

import 'models/restaurant.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantElement restaurants;
  final Menus menu;
  const DetailsPage({
    key,
    this.restaurants,
    this.menu,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState(
        restaurants,
        menu,
      );
}

class _DetailsPageState extends State<DetailsPage> {
  List<Widget> foodsList = [];
  List<Widget> drinksList = [];

  final RestaurantElement restaurants;
  final Menus menus;

  _DetailsPageState(
    this.restaurants,
    this.menus,
  ) {
    for (int i = 0; i < restaurants.menus.foods.length; i++) {
      foodsList.add(
        Image.asset(
          'assets/food.png',
          alignment: Alignment.center,
        ),
      );

      foodsList.add(
        Text(
          restaurants.menus.foods.map((e) => e.name).elementAt(i).toString(),
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }
    for (int i = 0; i < restaurants.menus.drinks.length; i++) {
      drinksList.add(
        Image.asset(
          'assets/drink.png',
          alignment: Alignment.center,
        ),
      );

      drinksList.add(
        Text(
          restaurants.menus.drinks.map((e) => e.name).elementAt(i).toString(),
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                FittedBox(
                  child: Image.network(
                    restaurants.pictureId,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.fill,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Image.network(restaurants.pictureId),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurants.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.yellow.shade400,
                            size: 14,
                          ),
                        ),
                        Text(
                          restaurants.city,
                          //restaurants.menus.foods.elementAt(1).toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(restaurants.description),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 8),
                    child: Text(
                      "Menus",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Foods",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow.shade400),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(bottom: 16),
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(children: foodsList),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Drinks",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow.shade400),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(bottom: 16),
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(children: drinksList),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
