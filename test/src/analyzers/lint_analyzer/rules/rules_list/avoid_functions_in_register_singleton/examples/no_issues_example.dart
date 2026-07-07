void main() {
  GetIt.I.registerSingleton(SomeClass());
  GetIt.instance.registerSingleton(const AnotherClass());
  GetIt.I.registerFactory(() => SomeClass());
  GetIt.I.registerLazySingleton(() => SomeClass());

  final getIt = GetIt.instance;
  getIt.registerSingleton(SomeClass());

  Registry().registerSingleton(() => SomeClass());
}

class SomeClass {
  SomeClass();
}

class AnotherClass {
  const AnotherClass();
}

class GetIt {
  const GetIt._();

  static const GetIt instance = GetIt._();

  static const GetIt I = instance;

  void registerSingleton<T>(T instance) {}

  T registerFactory<T>(T Function() factoryFunc) => factoryFunc();

  T registerLazySingleton<T>(T Function() factoryFunc) => factoryFunc();
}

class Registry {
  void registerSingleton<T>(T instance) {}
}
