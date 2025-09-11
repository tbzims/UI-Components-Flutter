import 'package:example/screen/view_model/main_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snto_im_ui/snto_im_ui.dart';

///应用主页
class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = useState("example");
    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(title.value),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SntoRecordList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
          ref
              .read(intlCurProvider.notifier)
              .changLocal(
                (counter.value % 4) == 1
                    ? Locale("zh")
                    : (counter.value % 4) == 2
                    ? Locale("en")
                    : (counter.value % 4) == 3
                    ? Locale("zh", "TW")
                    : Locale("km"),
              );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
