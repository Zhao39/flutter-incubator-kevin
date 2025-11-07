import 'dart:async';

class UserId {
  final String value;

  UserId(this.value) {
    if (value.length != 36) {
      throw ArgumentError('UserId must be exactly 36 characters long.');
    }
    final uuidV4Pattern = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    if (!uuidV4Pattern.hasMatch(value)) {
      throw ArgumentError('UserId must be in valid UUIDv4 format.');
    }
  }

  @override
  String toString() => value;
}

class UserName {
  final String value;

  UserName(this.value) {
    final pattern = RegExp(r'^[A-Za-z]{4,32}$');
    if (!pattern.hasMatch(value)) {
      throw ArgumentError(
        'UserName must contain only letters and be 4–32 characters long.',
      );
    }
  }

  @override
  String toString() => value;
}

class UserBio {
  final String value;

  UserBio(this.value) {
    if (value.length > 255) {
      throw ArgumentError('UserBio must not exceed 255 characters.');
    }
  }

  @override
  String toString() => value;
}

class User {
  const User({
    required this.id,
    this.name,
    this.bio,
  });

  final UserId id;

  final UserName? name;

  final UserBio? bio;
}

class Backend {
  Future<User> getUser(UserId id) async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulate delay
    return User(id: id);
  }

  Future<void> putUser(
    UserId id, {
    UserName? name,
    UserBio? bio,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulate delay
  }
}

class UserService {
  UserService(this.backend);

  final Backend backend;

  Future<User> get(UserId id) async {
    return backend.getUser(id);
  }

  Future<void> update(User user) async {
    await backend.putUser(
      user.id,
      name: user.name,
      bio: user.bio,
    );
  }
}

void main() async {
  final backend = Backend();
  final service = UserService(backend);

  final userId = UserId('550e8400-e29b-41d4-a716-446655440000');
  final name = UserName('Alice');
  final bio = UserBio('A software developer who loves Dart!');

  await service.update(User(id: userId, name: name, bio: bio));
  final fetchedUser = await service.get(userId);

  print('Fetched user ID: ${fetchedUser.id}');
}
