class UserRegisterDto {
  String username;
  String password;
  String confirmPassword;
  String name;
  String nip;
  String phone;
  String email;
  String address;
  String city;
  String postalCode;

  UserRegisterDto({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.nip,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.postalCode,
  });

  Map<String, dynamic> toJson() => {
        'Username': username,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'Name': name,
        'NIP': nip,
        'Phone': phone,
        'Email': email,
        'Address': address,
        'City': city,
        'PostalCode': postalCode,
      };
}