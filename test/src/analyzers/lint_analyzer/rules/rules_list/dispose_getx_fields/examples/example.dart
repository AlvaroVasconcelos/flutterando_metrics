class ShinyWidgetController extends GetxController {
  final _someDisposable = SomeDisposable();
  final _anotherDisposable = AnotherDisposable(); // LINT
  final _thirdDisposable = SomeDisposable(); // LINT
  final _notDisposable = NotDisposable();

  @override
  void onClose() {
    _someDisposable.dispose();

    super.onClose();
  }
}

class NoOnCloseController extends GetxService {
  final _someDisposable = SomeDisposable(); // LINT
}

class GetxController {
  void onClose() {}
}

class GetxService extends DisposableInterface {}

class DisposableInterface {
  void onClose() {}
}

class SomeDisposable {
  void dispose() {}
}

class AnotherDisposable {
  void dispose() {}
}

class NotDisposable {}
