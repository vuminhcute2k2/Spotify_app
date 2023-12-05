// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<ListToday> listToday = [
    ListToday(
        imgListToday:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameListToday: 'Dekat Di Hati',
        nameAuthor: 'RAN'),
    ListToday(
        imgListToday:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameListToday: 'Dekat Di Hati',
        nameAuthor: 'RAN'),
    ListToday(
        imgListToday:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameListToday: 'Dekat Di Hati',
        nameAuthor: 'RAN'),
     ListToday(
        imgListToday:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameListToday: 'Dekat Di Hati',
        nameAuthor: 'RAN'),
     ListToday(
        imgListToday:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameListToday: 'Dekat Di Hati',
        nameAuthor: 'RAN'),        
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Today',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 10,),    
                Container(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listToday.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              //color: Colors.grey
                              border: Border.all(width: 0.5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      listToday[index].imgListToday,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listToday[index].nameListToday,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        listToday[index].nameAuthor,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.more_vert,
                                  color: Color(0XFF1ED760),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Yesterday',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    itemCount: listToday.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              //color: Colors.grey
                              border: Border.all(width: 0.5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      listToday[index].imgListToday,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listToday[index].nameListToday,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        listToday[index].nameAuthor,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.more_vert,
                                  color: Color(0XFF1ED760),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListToday {
  String imgListToday;
  String nameListToday;
  String nameAuthor;
  ListToday({
    required this.imgListToday,
    required this.nameListToday,
    required this.nameAuthor,
  });
}
