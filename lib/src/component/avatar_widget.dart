import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// 다양한 아바타 스타일이 있음 => enum타입으로
enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  // 스토리를 봤는지, 있는지를 기준잡는 flag
  bool? hasStory;
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget({
    this.hasStory,
    required this.thumbPath,
    this.nickname,
    required this.type,
    this.size,
    Key? key,
  }) : super(key: key);

  Widget typeWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        // 그라디언트 효과
        gradient: LinearGradient(
          // 시작점
          begin: Alignment.topRight,
          // 종료점
          end: Alignment.bottomLeft,
          // 그라디언트 색깔들
          colors: [Colors.purple, Colors.orange],
        ),
        shape: BoxShape.circle,
      ),
      //flutter pub add cached_network_image
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(65),
          child: SizedBox(
              width: 65,
              height: 65,
              // 웹상의 이미지 호출하기
              // CachedNetworkImage 라이브러리 추가
              child: CachedNetworkImage(
                imageUrl: thumbPath,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      // type에 따라 Avatar모양이 바뀜
      // type1, type2, type3 switch문
      case AvatarType.TYPE1:
        return typeWidget();
        break;
      case AvatarType.TYPE2:
      case AvatarType.TYPE3:
    }
    return const Placeholder();
  }
}
