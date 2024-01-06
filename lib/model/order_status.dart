enum OrderStatus { NEW, PROCESSING, DONE}

extension ParseToString on OrderStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}
