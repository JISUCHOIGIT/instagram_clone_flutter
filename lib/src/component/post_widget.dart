import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/src/component/avatar_widget.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.TYPE3,
            nickname: 'JISUCHOIGIT',
            size: 40,
            thumbPath:
                'https://assets-global.website-files.com/6005fac27a49a9cd477afb63/6057684e5923ad2ae43c8150_bavassano_homepage_before.jpg',
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                icon: IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
        imageUrl: 'https://taegon.kim/wp-content/uploads/2018/05/image-5.png');
  }

  Widget _infoCount() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                icon: IconsPath.likeOffIcon,
                width: 65,
              ),
              SizedBox(width: 15),
              ImageData(
                icon: IconsPath.replyIcon,
                width: 60,
              ),
              SizedBox(width: 15),
              ImageData(
                icon: IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          ImageData(
            icon: IconsPath.bookMarkOffIcon,
            width: 50,
          )
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('좋아요 150개', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('콘텐츠 1입니다.',),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        // 포스트 하나에 구성된 위젯
        children: [
          _header(),
          SizedBox(height: 15),
          _image(),
          SizedBox(height: 15),
          _infoCount(),
          SizedBox(height: 5),
          _infoDescription(),
          // _replyTextBtn(),
          // _dateAgo(),
        ],
      ),
    );
  }
}
