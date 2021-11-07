import 'package:flutter/material.dart';

import 'details_page.dart';
import 'models/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RestaurantList.routeName,
      routes: {
        RestaurantList.routeName: (context) => RestaurantList(),
        DetailsPage.routeName: (context) => DetailsPage(
              restaurants: ModalRoute.of(context).settings.arguments
                  as RestaurantElement,
            ),
      },
    );
  }
}

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade300,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurant",
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
            Text(
              "Recommended restaurant for you!",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return Text("Gagal memuat data!");
          }
          final List<RestaurantElement> restaurants =
              restaurantFromJson(snapshot.data).restaurants;

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(
    BuildContext context, RestaurantElement restaurants) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, DetailsPage.routeName,
          arguments: restaurants);
    },
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            height: 100,
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(restaurants.pictureId),
                ),
                borderRadius: BorderRadius.circular(8)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: 165),
                  child: Text(
                    restaurants.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        right: 8,
                      ),
                      child: Icon(Icons.location_on,
                          color: Colors.yellow.shade400, size: 16),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            restaurants.city,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        right: 8,
                      ),
                      child: Icon(Icons.star,
                          color: Colors.yellow.shade400, size: 16),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            restaurants.rating.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
