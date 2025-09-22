import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

import '../../../router/app_router.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorMap['whiteColor1'],
      appBar: AppBar(
        title: const Text('Record List'),
        backgroundColor: theme.fontGyColor1,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            IMButton(
              text: '基础列表',
              onTap: () async {
                Navigator.of(context).pushNamed(RouterName.recordListBasic);
              },
            ),
            IMButton(
              text: '刷新列表',
              onTap: () async {
                Navigator.of(context).pushNamed(RouterName.recordListRefresh);
              },
            ),
            IMButton(
              text: 'Index列表',
              onTap: () async {
                Navigator.of(context).pushNamed(RouterName.recordListIndexed);
              },
            ),
          ],
        ),
      ),
    );
  }
}
