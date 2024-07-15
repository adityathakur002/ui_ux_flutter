class StudentEntity {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final String username;
  final String password;

  StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
  });
}
