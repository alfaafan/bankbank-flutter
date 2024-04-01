import 'package:hive/hive.dart';

part 'role.g.dart';

@HiveType(typeId: 4)
class Role extends HiveObject {
  @HiveField(0)
  final String roleName;

  Role({
    required this.roleName,
  });
}