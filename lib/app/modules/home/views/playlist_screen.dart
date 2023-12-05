// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final List<GridPlaylist> gridPlaylist =[
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
    GridPlaylist(imgPlaylist: 'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg', namePlaylist: 'Liked Songs', song: 128),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon:const Icon(Icons.search,color: Colors.white,)),
        title:const Text('Playlists',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){}, icon:const Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: gridPlaylist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        //margin: const EdgeInsets.only(right: 10, left: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(gridPlaylist[index].imgPlaylist,fit: BoxFit.cover,),
                        ),
                      ),
                      Text(gridPlaylist[index].namePlaylist,maxLines: 1,style:const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),),
                      Text('${gridPlaylist[index].song} Song',maxLines: 1,style:const TextStyle(color: Colors.white,fontSize: 12,overflow: TextOverflow.ellipsis),),
                    ],
                  ),
                ),
              );
            },
            
          ),
        ),
      ),
    );
  }
}
class GridPlaylist {
  String imgPlaylist;
  String namePlaylist;
  int song;
  GridPlaylist({
    required this.imgPlaylist,
    required this.namePlaylist,
    required this.song,
  });

}
