class VideoViewerController extends GetxController {
  @override
  void onInit() {
    doSomething();

    super.onInit(); // LINT
  }

  @override
  void onReady() {
    doSomething();

    super.onReady(); // LINT
  }

  @override
  void onStart() {
    doSomething();

    super.onStart(); // LINT
  }

  @override
  void onClose() {
    super.onClose(); // LINT

    doSomething();
  }

  @override
  void onDelete() {
    super.onDelete(); // LINT

    doSomething();
  }

  void doSomething() {}
}

class GetxService {
  void onInit() {}
}

class MyService extends GetxService {
  @override
  void onInit() {
    doSomething();

    super.onInit(); // LINT
  }

  void doSomething() {}
}

class GetxController {
  void onInit() {}

  void onReady() {}

  void onStart() {}

  void onClose() {}

  void onDelete() {}
}
