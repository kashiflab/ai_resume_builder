import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}

abstract class NavigationService {
  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  bool canPop({required BuildContext context});

  void navigateBack({required BuildContext context});

  void pushNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String> params = const <String, String>{},
  });
}

class GoRouterNavigationService extends NavigationService {
  GoRouterNavigationService();

  @override
  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.goNamed(
        uri,
        extra: data,
      );

  @override
  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.pushReplacementNamed(uri, extra: data);

  @override
  void navigateBack({required BuildContext context}) => context.pop();

  @override
  void pushNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String> params = const <String, String>{},
  }) {
    context.pushNamed(
      uri,
      extra: data,
      pathParameters: params,
    );
  }

  @override
  bool canPop({required BuildContext context}) {
    return context.canPop();
  }
}
