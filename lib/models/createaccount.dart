class CreateAccount {
  String? id;
  String? name;
  String? age;
  String? number;
  String? address;
  String? idNumber;
  String? email;

  CreateAccount(
      {this.id,
      this.name,
      this.age,
      this.number,
      this.address,
      this.idNumber,
      this.email});

  factory CreateAccount.fromMap(map) {
    return CreateAccount(
        id: map['id'],
        name: map['name'],
        age: map['age'],
        number: map['number'],
        address: map['address'],
        idNumber: map['idNumber'],
        email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'number': number,
      'address': address,
      'idNumber': idNumber,
      'email': email
    };
  }
}
