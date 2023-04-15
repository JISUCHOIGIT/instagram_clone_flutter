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
    selectedImage = imageList.first;
  }

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      // 정사각형으로 영역
      // Get.width / height
      width: width,
      height: width,
      child: selectedImage == null
          ? Container()
          : FutureBuilder(
              future: selectedImage!.thumbnailDataWithSize(
                ThumbnailSize(width.toInt(), width.toInt()),
              ),
              builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Container();
                }
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
          Padding(
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
        itemBuilder: (context, index) {
          return _photoWidget(imageList[index]);
        });
  }

  Widget _photoWidget(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(
        ThumbnailSize(200, 200),
      ),
      builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
          );
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
