// ignore_for_file: unused_element, unused_field

class Widget {
  const Widget();
}

class BuildContext {
  const BuildContext();
}

abstract class State<T> {
  Widget build(BuildContext context);
}

class GetxController {
  const GetxController();
}

class Rx<T> {
  Rx(this.value);

  T value;
}

class RxInt extends Rx<int> {
  RxInt(super.value);
}

extension IntObs on int {
  RxInt get obs => RxInt(this);
}

class Some extends Widget {
  const Some();
}

class _SomeState extends State<Some> {
  final count = 0.obs;
  final typed = RxInt(1);

  RxInt? lazy;

  void initState() {
    lazy = RxInt(2);
  }

  @override
  Widget build(BuildContext context) {
    count.value += typed.value;

    return const Widget();
  }
}

class ReportBuilder extends GetxController {
  int build(int input) {
    final counter = RxInt(input);

    return counter.value;
  }
}
