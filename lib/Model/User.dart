class User {
  String name;
  String email;
  int age = 0;
  // ignore: non_constant_identifier_names
  String phone_number;
  String address;
  String token;
  String role;
  List access_right;

  User(this.name, this.email, this.age, this.phone_number, this.address, this.token, {this.access_right, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json["name"],
        json["email"],
        json["age"],
        json["phone_number"],
        json["address"],
        json["token"],
        role: (json["user_roles"]!=null)?json["user_roles"][0]:"",
        access_right: json["access_right"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': this.name,
      'email': this.email,
      'age': this.age,
      'phone_number': this.phone_number,
      'address': this.address
    };
  }
}
