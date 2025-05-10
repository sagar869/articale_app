import 'package:bharat_next_task/home/presentation/bloc/home_bloc.dart';
import 'package:bharat_next_task/home/presentation/screen/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'fav_screen.dart';
import '../data/api_services/api_service.dart';
import '../data/model/data_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataList> postList = [];
  List<DataList> searchList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favBox = Hive.box('favBox');
    return BlocProvider(
      create: (_) => HomeBloc(ApiService())..add(FetchPosts()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts'), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritePage()),
                );
              },
              icon: const Icon(Icons.favorite_outline))
        ]),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              // Store original list only once
              if (postList.isEmpty) {
                postList = state.posts;
                searchList = postList;
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(FetchPosts());
                  searchList = state.posts;
                },
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by title',
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          onChanged: (value) => _filterData(
                            value,
                          ),
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchList.length, //state.posts.length,
                        itemBuilder: (context, index) {
                          return ValueListenableBuilder(
                              valueListenable: favBox.listenable(),
                              builder: (context, Box box, _) {
                                List favList =
                                    box.get('favList', defaultValue: []);
                                bool isFavorite = favList.any((item) =>
                                    item['title'] == searchList[index].title);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                data: searchList[index])),
                                      );
                                    },
                                    child: Card(
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "User ID:  ${searchList[index].userId}   ID: ${searchList[index].id}"),
                                                  InkWell(
                                                      onTap: () {
                                                        toggleFavorite(box,
                                                            searchList[index]);
                                                      },
                                                      child: Icon(
                                                        isFavorite
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                      )),
                                                ],
                                              ),
                                              Text(
                                                "Title : ${searchList[index].title}",
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  void toggleFavorite(Box box, DataList post) async {
    List favList = box.get('favList', defaultValue: []);

    bool exists = favList.any((item) => item['title'] == post.title);
    if (exists) {
      favList.removeWhere((item) => item['title'] == post.title);
    } else {
      favList.add(post.toJson());
    }
    await box.put('favList', favList);
  }

  void _filterData(
    String enteredKeyword,
  ) {
    List<DataList> results = [];
    if (enteredKeyword.isEmpty) {
      results = searchList;
    } else {
      results = postList
          .where((e) =>
              e.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      debugPrint("filterData: ${results.first.title}");
    }
    setState(() {
      searchList = results;
    });
  }
}
