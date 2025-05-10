import 'package:bharat_next_task/home/presentation/data/model/data_list.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final DataList data;
  const DetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User ID ${data.userId} Post Details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data.id}. ${data.title!.toUpperCase()}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Text("${data.body}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
