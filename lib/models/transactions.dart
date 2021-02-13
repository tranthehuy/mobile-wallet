class Transactions {
  final int id;
  final String name;
  final int amount;
  final String type;
  final int creationTime;

  Transactions({this.id, this.name, this.amount, this.type, this.creationTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type': type,
      'creationTime': creationTime
    };
  }

  // Implement toString to make it easier to see information about
  // each transactions when using the print statement.
  @override
  String toString() {
    return 'Transactions{id: $id, name: $name, price: $amount, type: $type, creationTime$creationTime';
  }
}