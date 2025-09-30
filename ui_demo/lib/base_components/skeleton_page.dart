import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart' as im;

import '../skeleton/im_skeleton.dart';

class SkeletonPage extends StatelessWidget {
  const SkeletonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = im.IMTheme.of(context);
    return Scaffold(
      backgroundColor: theme.brand6,
      appBar: AppBar(
        title: const Text('Skeleton 示例'),
        backgroundColor: theme.brand1,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title('预设主题骨架屏'),
              // 头像骨架屏
              const Text('头像骨架屏:'),
              IMSkeleton(theme: IMSkeletonTheme.avatar),
              const Text('图片骨架屏:'),
              IMSkeleton(theme: IMSkeletonTheme.image),
              const Text('文本骨架屏:'),
              IMSkeleton(theme: IMSkeletonTheme.text),
              const Text('段落骨架屏:'),
              IMSkeleton(theme: IMSkeletonTheme.paragraph),
              SizedBox(height: 10),
              title('自定义主题骨架屏'),
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
