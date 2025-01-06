import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; //thêm thư viện DateFormat

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String getCurrentUserId() {
    // Kiểm tra xem người dùng đã đăng nhập chưa
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Nếu đã đăng nhập, trả về ID của người dùng
      return user.uid;
    } else {
      return 'unknown_user';
    }
  }
  // Hàm lấy dữ liệu lịch sử nghe nhạc từ Firestore
 Stream<QuerySnapshot> getListeningHistory() {
    // Lấy userId hiện tại
    String userId = getCurrentUserId();

    // Truy vấn lịch sử nghe nhạc từ subcollection 'history' của người dùng
    return FirebaseFirestore.instance
        .collection('users') 
        .doc(userId)
        .collection('history') 
        .orderBy('playedAt', descending: true)
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Ẩn nút Back
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getListeningHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No music listening history",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final history = snapshot.data!.docs;

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        item['imageUrl'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item['artist'],
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    trailing: Text(
                      DateFormat('dd/MM/yyyy HH:mm') // Định dạng thời gian
                          .format(DateTime.parse(item['playedAt']).toLocal()),
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
