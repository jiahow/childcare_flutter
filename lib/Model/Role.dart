class Role {
  int id;
  String name;


  Role(this.id, this.name);

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
        json["id"],
        json["name"]
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': this.id,
      'name': this.name
    };
  }
}
