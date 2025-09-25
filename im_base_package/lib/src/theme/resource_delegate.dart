import 'package:flutter/cupertino.dart';
//
// typedef TDTDResourceBuilder =
//     TDResourceDelegate? Function(BuildContext context);
//
// /// 资源管理器
// class TDResourceManager {
//   /// 代理构建器
//   TDTDResourceBuilder? _builder;
//
//   /// 每次都调用build方法
//   bool _needAlwaysBuild = false;
//
//   TDResourceDelegate? _delegate;
//
//   /// 获取资源
//   TDResourceDelegate delegate(BuildContext context) {
//     if (_builder == null) {
//       return _defaultDelegate;
//     }
//     if (_needAlwaysBuild) {
//       // 每次都调用,适用于全局有多个TDResourceDelegate的情况
//       var delegate = _builder?.call(context);
//       if (delegate != null) {
//         return delegate;
//       }
//     }
//     _delegate ??= _builder?.call(context);
//     return _delegate ?? _defaultDelegate;
//   }
//
//   static TDResourceManager? _instance;
//
//   /// 单例对象
//   static TDResourceManager get instance {
//     _instance ??= TDResourceManager();
//     return _instance!;
//   }
//
//   /// 获取资源
//   static final _defaultDelegate = _DefaultResourceDelegate();
//
//   /// 设置资源代理
//   void setResourceBuilder(TDTDResourceBuilder delegate, needAlwaysBuild) {
//     _builder = delegate;
//     _needAlwaysBuild = needAlwaysBuild;
//   }
// }

