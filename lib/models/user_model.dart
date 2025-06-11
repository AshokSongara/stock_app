import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String bio;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object?> get props => [id, name, email, bio];
}