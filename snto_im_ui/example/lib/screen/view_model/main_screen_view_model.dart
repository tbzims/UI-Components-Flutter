import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_screen_view_model.g.dart';

class MainScreenViewState {
  final String text;
  MainScreenViewState({required this.text});

  MainScreenViewState copyWith({String? text}) {
    return MainScreenViewState(text: text ?? this.text);
  }
}

@riverpod
class MainScreenViewModel extends _$MainScreenViewModel {
  @override
  MainScreenViewState build() {
    return MainScreenViewState(text: "初始文本");
  }
}

@riverpod
class IntlCur extends _$IntlCur {
  @override
  Locale build() {
    return Locale("zh");
  }

  void changLocal(Locale local) {
    state = local;
  }
}
