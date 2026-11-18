/// Akun yang sedang login (dari `user` pada respons /api/auth/login/ dan /me/).
class Account {
  const Account({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.isEo,
  });

  final int id;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isEo;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json['id'] as int,
        username: json['username'] as String,
        email: (json['email'] as String?) ?? '',
        isAdmin: json['is_admin'] as bool? ?? false,
        isEo: json['is_eo'] as bool? ?? false,
      );

  String get roleLabel => isAdmin
      ? 'Admin'
      : isEo
          ? 'Event Organizer'
          : 'Peserta';
}
