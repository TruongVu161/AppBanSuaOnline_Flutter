enum ShoeType { the_thao, da, cao_got, boot, khac }

extension ParseToString on ShoeType {
  String toShortString() {
    return toString().split('.').last;
  }
}
