import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';
import 'package:instagram_clone_flutter/src/component/post_widget.dart';

import '../component/avatar_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _myStory() {
    // stack : 겹쳐서 배치해야하기 때문에 서로 겹치게 하는 설정'
    // https://chal-kak.tistory.com/156
    return Stack(
      children: [
        AvatarWidget(
            thumbPath:
                'https://cdn.aitimes.com/news/photo/202204/143854_149286_5624.png',
            size: 70,
            type: AvatarType.TYPE2),
        // Positioned 위젯은 stack에서만 작동, 2개의 위젯 겹치기 가능
        Positioned(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  height: 1.1
                ),
              ),
            ),
          ),
          right: 5,
          bottom: 0,
        ),
      ],
    );
  }

  // 로고 밑 avatar 영역
  Widget _storyBoardList() {
    return SingleChildScrollView(
      // 스크롤 방향 : horizontal(가로), vertical(세로)
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          _myStory(),
          const SizedBox(width: 5),
          ...List.generate(
            100,
            // AvatarWidget : 어디서든 사용하기에 따로 component 만듬
            (index) => AvatarWidget(
                thumbPath:
                    'https://assets-global.website-files.com/6005fac27a49a9cd477afb63/6057684e5923ad2ae43c8150_bavassano_homepage_before.jpg',
                type: AvatarType.TYPE1),
          ),
        ],
      ),
    );
  }

  Widget _postList(){
    return Column(
      children:
        List.generate(50, (index) => PostWidget()).toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar : logo
      appBar: AppBar(
        title: ImageData(
          icon: IconsPath.logo,
          width: 270,
        ),
        // appBar 버튼
        actions: [
          // 다이렉트 메시지
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
        // 앱바 선(음영)
        elevation: 0,
      ),
      // ListView 2가지 - 스토리보드, 게시글보드
      body: ListView(
        children: [
          // 스토리보드 리스트뷰
          _storyBoardList(),
          // 게시글보드 리스트뷰
          _postList(),
        ],
      ),
    );
  }
}
