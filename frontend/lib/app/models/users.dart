class User {
  final String Email;
  final String Password;
  final int SoBan;
  final String? id;
  final String Username;
  final String Name;
  final String Phone;
  final String Address;
  final String CapBac;
  final Object? Sum;


  User({
    email,
    pass,
    this.id,
    required this.Username,
    required this.SoBan,
    required this.Address,
    required this.CapBac,
    required this.Name,
    required this.Phone,
    required this.Sum,
  })  : Email = email,
        Password = pass;
  get email => Email;
  get pass => Password;
  get username => Username;

  User copyWith({
    String? email,
    String? pass,
    int? soban,
    String? id,
    String? Username,
    String? Name,
    String? Phone,
    String? Address,
    String? CapBac,
    Object? Sum,
  }) {
    return User(
      email: email ?? Email,
      pass: pass ?? Password,
      SoBan: SoBan ?? SoBan,
      id : id ?? this.id,
      Username: Username ?? this.Username,
      Name: Name ?? this.Name,
      Phone: Phone ?? this.Phone,
      Address: Address ?? this.Address,
      CapBac: CapBac ?? this.CapBac,
      Sum: Sum ?? this.Sum,
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      email: json['Email'] as String,
      pass: json['Password'] as String,
      SoBan: json['SoBan'] as int,
      id: json['_id'] as String,
      Username: json['Username'] as String,
      Name: json['Name'] as String,
      Phone: json['Phone'] as String,
      Address: json['Address'] as String,
      CapBac: json['CapBac'] as String,
      Sum: json['Sum'] as Object,
    );
  }

  Map<String, dynamic> toJson(String? id) {
    return {
      'id': id,
      'email': Email,
      'pass': Password,
      'SoBan': SoBan,
      'Address': Address,
      'Username': Username,
      'CapBac': CapBac,
      'Sum': Sum,
      'Phone': Phone,
      'Name': Name,
      };
  }

  void forEach(Null Function(dynamic element) param0) {}

}

class Sum {
  final String? id;
  final String? Ma;
  final String? Ten;

  Sum({
    this.id,
    required this.Ma,
    required this.Ten,
  });

  Sum coppyWith({
    String? id,
    String? Ma,
    String? Ten,
  }) {
    return Sum(
      id: id ?? this.id,
      Ma: Ma ?? this.Ma,
      Ten: Ten ?? this.Ten,
    );
  }

  static Sum fromJson(Map<String, dynamic> json) {
    return Sum(
      id: json['_id'],
      Ma: json['acclv_Ma'],
      Ten: json['acclv_Ten'],
    );
  }

  Map<String, dynamic> toJson(String? id) {
    final Map<String, dynamic> Sum = new Map<String, dynamic>();
    Sum['id'] = this.id;
    Sum['Ma'] = this.Ma;
    Sum['Ten'] = this.Ten;
    return Sum;
  }
}
