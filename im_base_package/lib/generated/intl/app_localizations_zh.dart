import 'app_localizations.dart';

/// The translations for Chinese (`zh`).
class ImUiLocalizationsZh extends ImUiLocalizations {
  ImUiLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '即时通讯组件库';

  @override
  String appCount(Object count) {
    return '应用数量是$count';
  }

  @override
  String get language => '语言';

  @override
  String get loading => '加载中...';

  @override
  String get pullToRefresh => '下拉刷新';

  @override
  String get releaseToRefresh => '松手刷新';

  @override
  String get refreshing => '刷新中...';

  @override
  String get refreshSuccess => '刷新成功';

  @override
  String get refreshFailed => '刷新失败';

  @override
  String get pullToLoad => '上拉加载更多';

  @override
  String get releaseToLoad => '松手加载更多';

  @override
  String get loadSuccess => '加载成功';

  @override
  String get loadFailed => '加载失败';

  @override
  String get noMore => '没有更多数据';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get confirm => '确认';

  @override
  String get cancel => '取消';

  @override
  String get pcLoadOnClick => '点击加载更多';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class ImUiLocalizationsZhTw extends ImUiLocalizationsZh {
  ImUiLocalizationsZhTw(): super('zh_TW');

  @override
  String get appTitle => '即時通訊元件庫';

  @override
  String appCount(Object count) {
    return '應用數量為 $count';
  }

  @override
  String get language => '語言';

  @override
  String get loading => '載入中...';

  @override
  String get pullToRefresh => '下拉重新整理';

  @override
  String get releaseToRefresh => '放開重新整理';

  @override
  String get refreshing => '重新整理中...';

  @override
  String get refreshSuccess => '重新整理成功';

  @override
  String get refreshFailed => '重新整理失敗';

  @override
  String get pullToLoad => '上拉載入更多';

  @override
  String get releaseToLoad => '放開載入更多';

  @override
  String get loadSuccess => '載入成功';

  @override
  String get loadFailed => '載入失敗';

  @override
  String get noMore => '沒有更多資料';

  @override
  String get edit => '編輯';

  @override
  String get delete => '刪除';

  @override
  String get confirm => '確認';

  @override
  String get cancel => '取消';

  @override
  String get pcLoadOnClick => '點擊加載更多';
}
