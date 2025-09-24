import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class RecordListIndexedPage extends StatelessWidget {
  const RecordListIndexedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);

    // 索引列表数据
    final Map<String, List<Widget>> indexedItems = {
      'A': [
        Container(padding: EdgeInsets.all(16), child: Text('Abb')),
        Container(padding: EdgeInsets.all(16), child: Text('Acc')),
        Container(padding: EdgeInsets.all(16), child: Text('Add')),
        Container(padding: EdgeInsets.all(16), child: Text('Apple')),
        Container(padding: EdgeInsets.all(16), child: Text('Animal')),
        Container(padding: EdgeInsets.all(16), child: Text('Application')),
      ],
      'B': [
        Container(padding: EdgeInsets.all(16), child: Text('Bbb')),
        Container(padding: EdgeInsets.all(16), child: Text('Bcc')),
        Container(padding: EdgeInsets.all(16), child: Text('Ball')),
        Container(padding: EdgeInsets.all(16), child: Text('Book')),
        Container(padding: EdgeInsets.all(16), child: Text('Building')),
        Container(padding: EdgeInsets.all(16), child: Text('Business')),
      ],
      'C': [
        Container(padding: EdgeInsets.all(16), child: Text('Cdd')),
        Container(padding: EdgeInsets.all(16), child: Text('Ccc')),
        Container(padding: EdgeInsets.all(16), child: Text('Cac')),
        Container(padding: EdgeInsets.all(16), child: Text('Car')),
        Container(padding: EdgeInsets.all(16), child: Text('Computer')),
        Container(padding: EdgeInsets.all(16), child: Text('Company')),
      ],
      'D': [
        Container(padding: EdgeInsets.all(16), child: Text('Dog')),
        Container(padding: EdgeInsets.all(16), child: Text('Door')),
        Container(padding: EdgeInsets.all(16), child: Text('Data')),
        Container(padding: EdgeInsets.all(16), child: Text('Design')),
        Container(padding: EdgeInsets.all(16), child: Text('Development')),
      ],
      'E': [
        Container(padding: EdgeInsets.all(16), child: Text('Elephant')),
        Container(padding: EdgeInsets.all(16), child: Text('Email')),
        Container(padding: EdgeInsets.all(16), child: Text('Engine')),
        Container(padding: EdgeInsets.all(16), child: Text('Education')),
      ],
      'F': [
        Container(padding: EdgeInsets.all(16), child: Text('Fish')),
        Container(padding: EdgeInsets.all(16), child: Text('File')),
        Container(padding: EdgeInsets.all(16), child: Text('Fire')),
        Container(padding: EdgeInsets.all(16), child: Text('Function')),
      ],
      'G': [
        Container(padding: EdgeInsets.all(16), child: Text('Goat')),
        Container(padding: EdgeInsets.all(16), child: Text('Game')),
        Container(padding: EdgeInsets.all(16), child: Text('Government')),
        Container(padding: EdgeInsets.all(16), child: Text('Group')),
      ],
    };

    List<String> indexList = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

    return Scaffold(
      backgroundColor: theme.brand6,
      appBar: AppBar(
        title: const Text('Indexed Record List'),
        backgroundColor: theme.brand1,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '索引列表（无刷新加载）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: IMRecordList.indexed(
                indexedItems: indexedItems,
                indexList: indexList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
