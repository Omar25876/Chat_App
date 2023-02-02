class MyUser {
  static const String COLLECTION_NAME = 'Users';
  String id;
  String name;
  String email;
  MyUser({required this.id, required this.name, required this.email});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email};
  }
}
