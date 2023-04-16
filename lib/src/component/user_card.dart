import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/src/component/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;
  const UserCard({required this.userId, required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 150,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                AvatarWidget(
                  thumbPath:
                      'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_206.jpg',
                  type: AvatarType.TYPE2,
                  size: 80,
                ),
                SizedBox(height: 10),
                Text(
                  userId,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(onPressed: () {}, child: Text('Follow')),
              ],
            ),
          ),
          Positioned(
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.grey,
                ),
              ),
              right: 5,
              top: 5),
        ],
      ),
    );
  }
}
