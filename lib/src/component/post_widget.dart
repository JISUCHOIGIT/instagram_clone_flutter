import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
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
          Text(
            '좋아요 150개',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //flutter pub add expandable_text
          ExpandableText(
            '콘텐츠1입니다\n콘텐츠1입니다\n콘텐츠1입니다\n콘텐츠1입니다\n콘텐츠1입니다\n',
            prefixText: 'JISUCHOIGIT',
            onPrefixTap: () {
              print('페이지이동');
            },
            prefixStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            // 펼치기 제목
            expandText: '더보기',
            // 접기 제목
            collapseText: '접기',
            maxLines: 3,
            // 텍스트 클릭 시 펼치기
            expandOnTextTap: true,
            // 텍스트 클릭 시 접기
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 109개 모두 보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '1일전',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // 포스트 하나에 구성된 위젯
        children: [
          _header(),
          SizedBox(height: 15),
          _image(),
          SizedBox(height: 15),
          _infoCount(),
          SizedBox(height: 5),
          _infoDescription(),
          SizedBox(height: 5),
          _replyTextBtn(),
          SizedBox(height: 5),
          _dateAgo(),
        ],
      ),
    );
  }
}
