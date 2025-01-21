class Usermodel {
  final String? id;
  final String username;
  final String email;
  final String password;

  const Usermodel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  tojson(){
    return {
      "id": id,
      "username": username,
      "email":email,
      "password":password
    };
  }
  
}