class VideoViewerController extends GetxController {
  final _someListener = Listener();
  final _anotherListener = Listener();
  final _thirdListener = Listener();
  final _disposedListener = Listener();

  @override
  void onInit() {
    super.onInit();

    _someListener.addListener(listener);
    _anotherListener.addListener(listener); // LINT
    _thirdListener.addListener(listener); // LINT
    _disposedListener.addListener(listener);
  }

  @override
  void onReady() {
    super.onReady();

    _anotherListener.addListener(listener); // LINT
  }

  @override
  void onClose() {
    _someListener.removeListener(listener);
    _thirdListener.removeListener(wrongListener);
    _disposedListener.dispose();

    super.onClose();
  }

  void listener() => print('empty');

  void wrongListener() => print('wrong');
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

// Copy-pasted from Flutter source code
abstract class Listenable {
  const Listenable();

  void addListener(VoidCallback listener);

  void removeListener(VoidCallback listener);
}

typedef VoidCallback = void Function();
