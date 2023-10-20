class User {

  final String email;
  final String name;
  final String image;
  final String id;


  User({required this.email,required this.name,required this.image,required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'email': email
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${email} - ${name} - ${image} - ${id}';
  }

}