class DisposedController extends GetxController {
  final _someDisposable = SomeDisposable();

  @override
  void onClose() {
    _someDisposable.dispose();
    super.onClose();
  }
}

class NoDisposableFieldsController extends GetxController {
  final _notDisposable = NotDisposable();
  final int _count = 0;

  void use() {
    print(_notDisposable);
    print(_count);
  }
}

class PlainClass {
  final someDisposable = SomeDisposable();
}

class GetxController {
  void onClose() {}
}

class SomeDisposable {
  void dispose() {}
}

class NotDisposable {}
