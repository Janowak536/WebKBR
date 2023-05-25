class UserRegisterDto {
  String username;
  String password;
  String confirmPassword;
  int clientId;
  String name;
  String nip;
  String phone;
  String email;
  String address;
  String city;
  String postalCode;
  String clientType;
  String discountCode;

  UserRegisterDto({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.clientId,
    required this.name,
    required this.nip,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.clientType,
    required this.discountCode,
  });

  Map<String, dynamic> toJson() => {
        'Username': username,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'ClientId': clientId,
        'Name': name,
        'NIP': nip,
        'Phone': phone,
        'Email': email,
        'Address': address,
        'City': city,
        'PostalCode': postalCode,
        'ClientType': clientType,
        'DiscountCode': discountCode,
      };
}
