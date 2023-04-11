import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';

import '../component/avatar_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // 로고 밑 avatar 영역
  Widget _storyBoardList() {
    return SingleChildScrollView(
      // 스크롤 방향
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          100,
          (index) => AvatarWidget(
              thumbPath:
                  'https://assets-global.website-files.com/6005fac27a49a9cd477afb63/6057684e5923ad2ae43c8150_bavassano_homepage_before.jpg',
              type: AvatarType.TYPE1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImageData(
          icon: IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                icon: IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
        // 앱바 선
        elevation: 0,
      ),
      body: ListView(
        children: [
          // 스토리보드 리스트뷰
          _storyBoardList(),
          //_postList(),
        ],
      ),
    );
  }
}
