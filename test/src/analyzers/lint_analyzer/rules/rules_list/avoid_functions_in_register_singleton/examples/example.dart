void main() {
  GetIt.I.registerSingleton(() => SomeClass()); // LINT
  GetIt.instance.registerSingleton(() => SomeClass()); // LINT

  final getIt = GetIt.instance;
  getIt.registerSingleton(() => SomeClass()); // LINT
  getIt.registerSingleton(SomeClass.new); // LINT
  getIt.registerSingleton(_createInstance); // LINT
}

SomeClass _createInstance() => SomeClass();

class SomeClass {
  SomeClass();
}

class GetIt {
  const GetIt._();

  static const GetIt instance = GetIt._();

  static const GetIt I = instance;

  void registerSingleton<T>(T instance) {}

  T registerFactory<T>(T Function() factoryFunc) => factoryFunc();

  T registerLazySingleton<T>(T Function() factoryFunc) => factoryFunc();
}
