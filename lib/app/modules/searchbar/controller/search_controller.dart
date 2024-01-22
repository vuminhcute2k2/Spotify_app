import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchControllerBar extends GetxController {
  var postDocumentList = <QueryDocumentSnapshot>[].obs;
  var nameSongText = ''.obs;

  void initSearching() async {
    if (nameSongText.value.isNotEmpty) {
      try {
        var upperCaseText = nameSongText.value.toUpperCase();
        var lowerCaseText = nameSongText.value.toLowerCase();

        var result = await FirebaseFirestore.instance
            .collection('today-songs')
            .where('nameSong', isEqualTo: upperCaseText)
            .get();

        if (result.docs.isEmpty) {
          result = await FirebaseFirestore.instance
              .collection('today-songs')
              .where('lowerCaseName', isEqualTo: lowerCaseText)
              .get();
        }

        postDocumentList.assignAll(result.docs);
      } catch (e) {
        print("Error searching: $e");
      }
    } else {
      postDocumentList.clear();
    }
  }
}
