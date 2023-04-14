import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  Widget _imagePreview() {
    return Container(
      // 정사각형으로 영역
      // Get.width / height
      width: Get.width,
      height: Get.width,
      color: Colors.grey,
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                // 갤러리 선택시 photomanager로 직접 디바이스 내의 선택사항 가져올것
                Text(
                  '갤러리',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    ImageData(
                      icon: IconsPath.imageSelectIcon,
                    ),
                    SizedBox(width: 7),
                    Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(
                  icon: IconsPath.cameraIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    // SliverGridDelegateWithFixedCrossAxisCount :
    // singlechildscrollview & girdview 같이 사용할 경우 physics: NeverScrollableScrollPhysics(), 명시해서 방지하기
    return GridView.builder(
      // 스크롤 방식 금지
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // childAspectRatio : 숫자 비율에 따라 사각형 모양으로
          crossAxisCount: 4,
          // 간격조절
          mainAxisSpacing: 1,
          // 간격조절
          crossAxisSpacing: 1,
          // 간격조절
          childAspectRatio: 1),
      itemBuilder: (context, index) => Container(
        color: Colors.red,
      ),
      itemCount: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ImageData(
              icon: IconsPath.closeImage,
            ),
          ),
        ),
        title: Text(
          'New Post',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                icon: IconsPath.nextImage,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
