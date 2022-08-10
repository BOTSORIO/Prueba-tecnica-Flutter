class UserModel {
  String usuario;
  String? name;
  String password;
  String bussines;

  UserModel({
    required this.usuario,
    this.name,
    required this.password,
    required this.bussines,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        usuario: json["usuario"] ?? json["codigo"],
        name: json["nombre"],
        password: json["password"] ?? '',
        bussines: json["empresa"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": name,
        "password": password,
        "empresa": bussines,
      };
}
