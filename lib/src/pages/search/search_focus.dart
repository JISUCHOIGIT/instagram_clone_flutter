import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';

import '../../controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  // 메뉴이름 받기
  Widget tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  PreferredSizeWidget tabMenu() {
    return PreferredSize(
      child: Container(
        // 전체 가로 사이즈
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe4e4e4))),
        ),
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        // TabBar controller 필요
        child: TabBar(
          controller: tabController,
          // 탭바 스와이핑 컬러
          indicatorColor: Colors.black,
          tabs: [
            tabMenuOne('인기'),
            tabMenuOne('계정'),
            tabMenuOne('오디오'),
            tabMenuOne('태그'),
            tabMenuOne('장소'),
          ],
        ),
      ),
      // AppBar().preferredSize.height : appBar 만큼의 사이즈
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: [
        Center(child: Text('인기페이지')),
        Center(child: Text('계정페이지')),
        Center(child: Text('오디오페이지')),
        Center(child: Text('태그페이지')),
        Center(child: Text('장소페이지')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              icon: IconsPath.backBtnIcon,
            ),
          ),
          onTap: BottomNavController.to.willPopAction,
        ),
        // titleSpacing : 타이틀 마진 간격
        titleSpacing: 0,
        title: Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xffefefef),
          ),
          child: TextField(
            decoration: InputDecoration(
              // 텍스트 필드 밑줄 제거
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              // 간격이 줄어듬 = true, 패딩을 주는만큼 간격이 좁혀짐
              isDense: true,
            ),
          ),
        ),
        bottom: tabMenu(),
      ),
      body: _body(),
    );
  }
}
