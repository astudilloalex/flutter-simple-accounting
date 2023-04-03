class Auth {
  const Auth({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    required this.uid,
  });

  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String uid;
}
