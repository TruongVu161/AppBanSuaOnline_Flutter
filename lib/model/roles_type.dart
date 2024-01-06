enum RolesType { none, customer, admin }

extension ParseToString on RolesType {
  String toShortString() {
    return toString().split('.').last;
  }
}
