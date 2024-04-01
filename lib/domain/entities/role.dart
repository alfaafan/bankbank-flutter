class RoleModel {
  String roleName;

  RoleModel({
    required this.roleName,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    roleName: json["RoleName"],
  );

  Map<String, dynamic> toJson() => {
    "RoleName": roleName,
  };
}