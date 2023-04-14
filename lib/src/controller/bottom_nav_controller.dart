import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/message_popup.dart';
import '../pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {

  static BottomNavController get to => Get.find();

  RxInt pageIndex = 0.obs;
  // key 관리
  GlobalKey<NavigatorState> searchPageNavigationKey = GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    // 페이지 값에 대한 enum 타입이 들어옴
    var page = PageName.values[value];
    pageIndex(value);

    // history : value 값을 더하고 빼는 list형식으로 만듬
    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    // upload 제외한 나머지만 변동
    pageIndex(value);
    if (!hasGesture) return;
    // 값은 페이지값이 여러개 들어가는 걸 방지하기 위해
    if (bottomHistory.last != value) {
      // if (bottomHistory.contains(value)) {
      //   bottomHistory.remove(value);
      // }
      bottomHistory.add(value);
      print(bottomHistory);
      // 누적될 수 있도록 하도록 조치
      // [0, 1, 3, 4] => [0, 1, 3, 4, 0]
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          cancelCallback: Get.back,
          title: '알림',
          message: '종료하시겠습니까?',
          okCallback: () {
            exit(0);
          },
        ),
      );
      return true;
    } else {

      var page = PageName.values[bottomHistory.last];
      if(page == PageName.SEARCH) {
        // search -> 검색 -> pop할게 있으면 -> 검색 이미지 -> 홈
        var value = await searchPageNavigationKey.currentState!.maybePop();
        if(value) return false;
      }

      print('goto before page!');
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      print(bottomHistory);
      // [0, 0, 0, 1, 1] 오류가 생김
      // 직접적인 사용자의 Gesture 구분이 필요
      return false;
    }
  }
}
