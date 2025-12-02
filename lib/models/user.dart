class User {
  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final double rating;
  final int ratingCount;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatarUrl,
    this.rating = 5.0,
    this.ratingCount = 0,
  });
}
