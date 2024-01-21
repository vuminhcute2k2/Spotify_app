import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/searchbar/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final SearchControllerBar searchController = Get.put(SearchControllerBar());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 10, 181, 58),
                Color.fromARGB(255, 101, 255, 219)
              ],
            ),
          ),
        ),
        title: TextField(
          onChanged: (textEntered) {
            searchController.nameSongText.value = textEntered;
          },
          decoration: InputDecoration(
            hintText: 'Search music ',
            hintStyle: const TextStyle(color: Colors.white),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                searchController.initSearching();
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Obx(
                () {
                  var controller = Get.find<SearchControllerBar>();
                  var postDocumentList = controller.postDocumentList;

                  if (postDocumentList.isEmpty) {
                    return Center(
                      child: Text("Không tìm thấy kết quả"),
                    );
                  }

                  return ListView(
                    children: postDocumentList.map((document) {
                      var data = document.data() as Map<String, dynamic>;
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(data['nameSong']),
                          leading: Image.network(data['image']),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
