import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// 다양한 아바타 스타일을 => enum타입으로 지정
enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  // 스토리를 봤는지, 있는지를 기준잡는 flag

  // 스토리가 있으면 그라디언트, 스토리 봤을경우 회색처리
  bool? hasStory;

  // 이미지 주소
  String thumbPath;

  // 닉네임이 있으면 닉네임 나오게, 없으며 닉네임 없이
  String? nickname;

  // AvatarType
  AvatarType type;

  // 사이즈
  double? size;

  AvatarWidget({
    this.hasStory,
    required this.thumbPath,
    this.nickname,
    required this.type,
    this.size = 65,
    Key? key,
  }) : super(key: key);

  Widget type1Widget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        // 그라디언트 효과
        gradient: LinearGradient(
          // 색 방향 시작점
          begin: Alignment.topRight,
          // 색 방향 종료점
          end: Alignment.bottomLeft,
          // 그라디언트 색깔들
          colors: [Colors.purple, Colors.orange],
        ),
        shape: BoxShape.circle,
      ),
      //flutter pub add cached_network_image
      // 같은 위젯을 사용하기에 기본적인 위젯을 따로 만들고 지정
      child: type2Widget(),
    );
  }

  Widget type2Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      // 이미지가 넘쳐서 ClipRRect로 감싸서 radius 만들기
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65),
        child: SizedBox(
            width: size,
            height: size,
            // 웹상의 이미지 호출하기
            // CachedNetworkImage 라이브러리 추가
            child: CachedNetworkImage(
              imageUrl: thumbPath,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        type1Widget(),
        Text(nickname ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // type에 따라 다른 Avatar Widget return
    // type1, type2, type3 switch 문
    switch (type) {
    // 스토리 있는 다른 사용자들 type
      case AvatarType.TYPE1:
        return type1Widget();
        break;
    // 자기 스토리 위젯
      case AvatarType.TYPE2:
        return type2Widget();
        break;
      case AvatarType.TYPE3:
        return type3Widget();
    }
    return const Placeholder();
  }
}
