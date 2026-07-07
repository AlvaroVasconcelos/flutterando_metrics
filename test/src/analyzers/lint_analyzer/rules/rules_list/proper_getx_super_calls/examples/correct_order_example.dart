class VideoViewerController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    doSomething();
  }

  @override
  void onReady() {
    super.onReady();

    doSomething();
  }

  @override
  void onStart() {
    super.onStart();

    doSomething();
  }

  @override
  void onClose() {
    doSomething();

    super.onClose();
  }

  @override
  void onDelete() {
    doSomething();

    super.onDelete();
  }

  void doSomething() {}
}

class NoSuperController extends GetxController {
  @override
  void onInit() {
    doSomething();
  }

  void doSomething() {}
}

class SomeBase {
  void onInit() {}

  void onClose() {}
}

class NotGetx extends SomeBase {
  @override
  void onInit() {
    doSomething();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();

    doSomething();
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
