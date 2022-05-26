class UserCredintial {
  final int id;
  final String email;
  final String password;
  final String role;

  UserCredintial({required this.id,required this.role,required this.email, required this.password});

  factory UserCredintial.fromJson(Map<String, dynamic> json) {
    return UserCredintial(
      id: json['id'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "role": role
  };
}
