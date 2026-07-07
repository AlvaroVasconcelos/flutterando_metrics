final RxInt topLevelCounter = RxInt(0);

void fn() {
  final rx = Rx<int>(0);
  final list = <String>[].obs;
  final set = <String>{}.obs;
  final map = <String, String>{}.obs;

  int plain = 0;
  List<String> mutableList = [];
  var name = 'value';

  plain += mutableList.length + name.length;
}

class SomeController {
  final count = RxInt(0);
  final RxnString name = RxnString();

  static const answer = 42;

  int plain = 0;
  List<String> mutableList = [];
}

class RxLike {
  int value = 0;
}

class Rx<T> {
  T value;
  Rx(this.value);
}

class Rxn<T> extends Rx<T?> {
  Rxn([T? value]) : super(value);
}

class RxInt extends Rx<int> {
  RxInt(super.value);
}

class RxnString extends Rxn<String> {
  RxnString([super.value]);
}

class RxList<E> extends Rx<List<E>> {
  RxList(super.value);
}

class RxSet<E> extends Rx<Set<E>> {
  RxSet(super.value);
}

class RxMap<K, V> extends Rx<Map<K, V>> {
  RxMap(super.value);
}

extension ListExtension<E> on List<E> {
  RxList<E> get obs => RxList<E>(this);
}

extension SetExtension<E> on Set<E> {
  RxSet<E> get obs => RxSet<E>(this);
}

extension MapExtension<K, V> on Map<K, V> {
  RxMap<K, V> get obs => RxMap<K, V>(this);
}
