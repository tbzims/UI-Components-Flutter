import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = IMTheme.of(context);
    return Scaffold(
      backgroundColor: theme.brand6,
      appBar: AppBar(
        title: const Text('Avatar示例'),
        backgroundColor: IMTheme.of(context).brand1,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title('Text 字符头像'),
              Row(
                spacing: 10,
                children: [
                  IMAvatar.text(
                    text: 'A',
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      height: 0,
                    ),
                  ),
                  IMAvatar.text(
                    text: 'A',
                    radius: 10,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      height: 0,
                    ),
                  ),
                ],
              ),
              title('Image 图片头像'),
              Row(
                spacing: 10,
                children: [
                  IMAvatar.image(imagePath: 'assets/images/image_avatar.png'),
                  IMAvatar.image(
                    imagePath: 'assets/images/image_avatar.png',
                    radius: 10,
                  ),
                ],
              ),
              title('Icon 图标头像'),
              Row(
                spacing: 10,
                children: [
                  IMAvatar.icon(
                    size: 30,
                    iconPath: Icons.camera_alt_rounded,
                    bgColor: theme.brand5,
                  ),
                  IMAvatar.icon(
                    size: 30,
                    iconPath: Icons.camera_alt_rounded,
                    bgColor: theme.brand5,
                    radius: 10,
                  ),
                ],
              ),
              title('Placeholder 占位头像'),
              Row(
                spacing: 10,
                children: [
                  IMAvatar.placeholder(size: 60),
                  IMAvatar.placeholder(size: 60, radius: 10),
                ],
              ),
              title('File 文件头像'),
              Row(
                spacing: 10,
                children: [
                  IMAvatar.file(
                    size: 60,
                    imagePath: 'assets/images/file_avatar.png',
                    text: 'PPT',
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      height: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
