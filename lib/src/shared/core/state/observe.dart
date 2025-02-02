import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodObserver extends ProviderObserver {
  static const name = 'Riverpod';

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    log(
      '🧪 provider add: ${provider.name ?? provider.runtimeType}',
      name: name,
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if ('$newValue'.length >= 500) return;
    log(
      '''💉 provider updated: ${provider.name ?? provider.runtimeType} [$previousValue -> $newValue]''',
      name: name,
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    log(
      '🩸 provider disposed: ${provider.name ?? provider.runtimeType}',
      name: name,
    );
  }
}
