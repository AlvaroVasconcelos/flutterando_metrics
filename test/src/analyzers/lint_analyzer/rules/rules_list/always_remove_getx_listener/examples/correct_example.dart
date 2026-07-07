class ProperController extends GetxController {
  final _someListener = Listener();

  @override
  void onInit() {
    super.onInit();

    _someListener.addListener(listener);
  }

  @override
  void onClose() {
    _someListener.removeListener(listener);

    super.onClose();
  }

  void listener() => print('empty');
}

class SomeService extends GetxService {
  final _listener = Listener();

  @override
  void onInit() {
    super.onInit();

    _listener.addListener(listener);
  }

  @override
  void onClose() {
    _listener.dispose();

    super.onClose();
  }

  void listener() => print('empty');
}

class NotAController {
  final _listener = Listener();

  void onInit() {
    _listener.addListener(() {});
  }
}

class Listener implements Listenable {
  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  void dispose() {}
}

class GetxController {
  void onInit() {}
  void onReady() {}
  void onClose() {}
}

class GetxService {
  void onInit() {}
  void onClose() {}
}

// Copy-pasted from Flutter source code
abstract class Listenable {
  const Listenable();

  void addListener(VoidCallback listener);

  void removeListener(VoidCallback listener);
}

typedef VoidCallback = void Function();
