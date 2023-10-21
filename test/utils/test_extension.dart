import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<void> tapByKeyAndSettle(
    Key key, {
    Finder Function(Finder finder)? getFinder,
  }) async {
    return _performActionByKeyAndSettle(
      find.byKey(key),
      (finder) async {
        await tap(finder, warnIfMissed: false);
      },
    );
  }

  Future<void> enterTextByKeyAndSettle(
    Key key,
    String text,
  ) async =>
      _performActionByKeyAndSettle(
        find.byKey(key),
        (finder) async => await enterText(finder, text),
      );

  T widgetByKey<T>(Key key) => widget(find.byKey(key)) as T;

  T stateByKey<T>(Key key) => state(find.byKey(key)) as T;

  Future<void> scrollUntilVisibleByKeys(
    ValueKey<String> scrollViewKey,
    ValueKey<String> widgetKey,
  ) async {
    await scrollUntilVisible(
      find.byKey(widgetKey),
      0,
      scrollable: _scrollableFinder(scrollViewKey),
    );
  }

  Future<void> _performActionByKeyAndSettle(
    Finder finder,
    Future<void> Function(Finder finder) action,
  ) async {
    ensureVisible(finder);
    expect(finder, findsOneWidget);
    await action(finder);
    final _ = await pumpAndSettle();
  }

  Finder _scrollableFinder(ValueKey<String> scrollViewKey) => find.byWidget(find
      .descendant(
        of: find.byKey(scrollViewKey),
        matching: find.byType(Scrollable),
      )
      .evaluate()
      .where(
          (e) => (e.widget as Scrollable).axisDirection == AxisDirection.down)
      .first
      .widget);
}
