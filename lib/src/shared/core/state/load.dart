import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin Load on AutoDisposeAsyncNotifier<void> {
  Future<void> load(Future<void> Function() task) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(task);
  }
}
