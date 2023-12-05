
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_spotify_app/generated/image_constants.dart';

class Artist {
  String imageArtist;
  String nameArtist;
  String follow;
  Artist({
    required this.imageArtist,
    required this.nameArtist,
    required this.follow,
  });
  
}
List<Artist> listArtist =[
  Artist(imageArtist:'https://img6.thuthuatphanmem.vn/uploads/2022/01/25/hinh-anh-lofi-chill-tam-trang_042528419.jpg' , nameArtist: 'Adele', follow: '43,877,516 monthly listeners'),
  Artist(imageArtist:'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg' , nameArtist: 'Adele', follow: '43,877,516 monthly listeners'),
  Artist(imageArtist:'https://phunugioi.com/wp-content/uploads/2021/11/hinh-anh-chill-hoat-hinh.jpg' , nameArtist: 'Adele', follow: '43,877,516 monthly listeners'),
];
Widget ItemArtist(BuildContext context){
  return ListView.builder(
    itemCount:listArtist.length ,
    itemBuilder: (_,index){
      return Container(
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 85,
              height: 85,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network(listArtist[index].imageArtist),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,left: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listArtist[index].nameArtist,style:const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  Text(listArtist[index].follow,style:const TextStyle(color: Colors.white),textAlign: TextAlign.left,),
                ],
              ),
            ),
            GestureDetector(child: SvgPicture.asset(ImageConstant.imgVector)),
          ],
        ),
      );
    },
  );
}







