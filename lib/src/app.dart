import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';
import 'package:instagram_clone_flutter/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WillPopScope : back button 금지
    return WillPopScope(
        child: Obx(
          () => Scaffold(
            appBar: AppBar(),
            // 탭 변경 시 container도 변경
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                Container(child: Center(child: Text('Home'))),
                Container(child: Center(child: Text('Search'))),
                Container(child: Center(child: Text('Upload'))),
                Container(child: Center(child: Text('Activity'))),
                Container(child: Center(child: Text('Mypage'))),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              // 현재 탭한 위치
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              // 탭시 value 값을 가져옴
              onTap: controller.changeBottomNav,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: ImageData(
                      icon: IconsPath.homeOff,
                    ),
                    activeIcon: ImageData(
                      icon: IconsPath.homeOn,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageData(
                      icon: IconsPath.searchOff,
                    ),
                    activeIcon: ImageData(
                      icon: IconsPath.searchOn,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageData(
                      icon: IconsPath.uploadIcon,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageData(
                      icon: IconsPath.activeOff,
                    ),
                    activeIcon: ImageData(
                      icon: IconsPath.activeON,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  label: 'home',
                ),
              ],
            ),
          ),
        ),
        onWillPop: controller.willPopAction,);
  }
}
