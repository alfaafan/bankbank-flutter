class Role {
  String roleName;

  Role({
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    roleName: json["RoleName"],
  );

  Map<String, dynamic> toJson() => {
    "RoleName": roleName,
  };
}