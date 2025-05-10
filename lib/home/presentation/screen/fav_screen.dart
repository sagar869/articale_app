import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/model/data_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favBox = Hive.box('favBox');

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ValueListenableBuilder(
        valueListenable: favBox.listenable(),
        builder: (context, Box box, _) {
          List favList = box.get('favList', defaultValue: []);
          List<DataList> favorites = favList
              .map<DataList>(
                  (item) => DataList.fromJson(Map<String, dynamic>.from(item)))
              .toList();
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final fav = favorites[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${fav.id}. ${fav.title}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(Icons.delete, color: Colors.red),
                            onTap: () {
                              favorites.removeAt(index);
                              final updatedList =
                                  favorites.map((f) => f.toJson()).toList();
                              box.put('favList', updatedList);
                            },
                          ),
                        ],
                      ),
                      Text(fav.body ?? ''),
                    ],
                  ),
                )),
              );
            },
          );
        },
      ),
    );
  }
}
