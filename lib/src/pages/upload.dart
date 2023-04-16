import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/src/component/iamge_data.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  // _loadPhotos albums 아래와 같이 넘어옴
  var albums = <AssetPathEntity>[];
  var imageList = <AssetEntity>[];
  var headerTitle = '';
  AssetEntity? selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPhotos();
  }

  // 카메라 앨범 내 이미지 가져오기
  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    // 권한이 있을경우
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: FilterOption(
            sizeConstraint: SizeConstraint(minWidth: 100, minHeight: 100),
          ),
          orders: [
            OrderOption(
              type: OrderOptionType.createDate,
              asc: false,
            ),
          ],
        ),
      );
      // 사진 호출
      _loadData();
    } else {
      // message 권한 요청
    }
  }

  // 업로드 시 setState
  void update() => setState(() {});

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  // 이미지 사이즈 지정
  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    // 이미지 리스트의 첫번째
    selectedImage = imageList.first;
  }

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      // 정사각형으로 영역
      // Get.width / height
      width: width,
      height: width,
      // null 일경우 container 리턴 아닐 경우 썸네일 로드
      child: selectedImage == null
          ? Container()
          : _photoWidget(
              selectedImage!,
              width.toInt(),
              builder: (data) {
                return Image.memory(
                  data!,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // bottomsheet modal로 띄우기
              // 기본 color : white
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                // isScrollControlled: true, bottomModal 사이즈를 전체로 띄우기
                isScrollControlled: albums.length > 10 ? true : false,
                // 전체 사이즈 - 상단 액션바
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top),
                builder: (context) => Container(
                  // modal size 지정
                  height: albums.length > 10 ? Size.infinite.height : albums.length * 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 7),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      // 영역이 많아지면 overflow가 되기때문에 그에 해당하는 위젯에 SingleChildScrollView 넣기
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                albums.length,
                                (index) => Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25),
                                      child: Text(albums[index].name),
                                    )).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  // 갤러리 선택시 photomanager로 직접 디바이스 내의 선택사항 가져올것
                  Text(
                    headerTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
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
      itemCount: imageList.length,
      itemBuilder: (BuildContext context, int index) {
        return _photoWidget(
          imageList[index],
          200,
          builder: (data) => GestureDetector(
            onTap: () {
              selectedImage = imageList[index];
              update();
            },
            child: Opacity(
              // asset과 selectedImage가 같다면 opacity 주기
              opacity: imageList[index] == selectedImage ? 0.3 : 1,
              child: Image.memory(
                data!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        } else {
          return Container();
        }
      },
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
