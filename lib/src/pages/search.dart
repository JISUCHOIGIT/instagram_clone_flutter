import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_clone_flutter/src/pages/search/search_focus.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // 이중 리스트
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 100개 반복해서 만들어서 groupBox에 넣기
    // flutter pub add quiver
    for (var i = 0; i < 200; i++) {
      groupIndex.indexOf(min<int>(groupIndex)!);
      var gi = i % 3;
      var size = 1;
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gi].add(size);
      groupIndex[gi] += size;
    }
    print(groupBox);
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              // 밑에 bottomNavigator 유지
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFocus(),));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xffefefef),
              ),
              // 아이콘, 검색 2개가 필요
              child: Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(fontSize: 15, color: Color(0xff838383)),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  // Grid 영역
  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupBox.length,
          (index) => Expanded(
            child: Column(
              children: List.generate(
                groupBox[index].length,
                (jndex) => Container(
                  height: Get.width * 0.33 * groupBox[index][jndex],
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3kBJNOiNjCbgxLrjE1azwFvb24NXLVweQQA&usqp=CAU',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ).toList(),
        // [
        //   Expanded(
        //     child: Column(
        //       children: [
        //         Container(
        //           height: 140,
        //           color: Colors.red,
        //         ),
        //         Container(
        //           height: 140,
        //           color: Colors.red,
        //         ),
        //         Container(
        //           height: 140,
        //           color: Colors.grey,
        //         ),
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //     child: Column(
        //       children: [
        //         Container(
        //           height: 140,
        //           color: Colors.blue,
        //         ),
        //         Container(
        //           height: 140,
        //           color: Colors.red,
        //         ),
        //         Container(
        //           height: 140,
        //           color: Colors.yellow,
        //         ),
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //     child: Column(
        //       children: [
        //         Container(
        //           height: 140,
        //           color: Colors.grey,
        //         ),
        //         Container(
        //           height: 280,
        //           color: Colors.blue,
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // appBar 쓰게되면 고정이 되서 따로 만듬
            _appbar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}
