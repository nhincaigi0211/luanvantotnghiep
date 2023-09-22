// class Login {
//   final String _email;
//   final String _pass;
//   final String id;
//   final String Username;
//   final String Address;
//   final String Name;
//   final String Phone;
//   final String CapBac;
//   final int SoBan;
//   final Object? Sum;

//   Login( {email, pass,
//    required this.id, 
//    required this.Username,
//    required this.Address,
//    required this.Name,
//    required this.Phone, 
//    required this.CapBac,
//    required this.SoBan,
//    required this.Sum
//    })
//       : _email = email,
//         _pass = pass;

//   get email => _email;
//   get pass => _pass;

//   Login copyWith({
//     String? email,
//     String? pass,
//     String? id,
//     String? Username,
//     String? Address,
//     String? Name,
//     String? Phone,
//     String? CapBac,
//     int? SoBan,
//     Object? Sum
//     }) {
//     return Login(
//         email: email ?? _email,
//         pass: pass ?? _pass,
//         id: id ?? this.id,
//         Username: Username ?? this.Username,
//         Address: Address ?? this.Address,
//         CapBac: CapBac ?? this.CapBac,
//         Name: Name ?? this.Name,
//         Phone: Phone ?? this.Phone,
//         SoBan: SoBan ?? this.SoBan,
//         Sum: Sum ?? this.Sum
//         );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'email': _email,
//       'pass': _pass,
//       'id': id,
//       'Username': Username,
//       'Address': Address,
//       'Name': Name,
//       'Phone': Phone,
//       'CapBac': CapBac,
//       'SoBan': SoBan,
//       'Sum': Sum
//       };
//   }

//   static Login fromJson(Map<String, dynamic> json) {
//     return Login(
//         email: json['Email'] as String,
//         pass: json['Password'] as String,
//         id: json['_id'] as String,
//         Username: json['Username'] as String,
//         Address: json['Address'] as String,
//         Name: json['Name'] as String,
//         Phone: json['Phone'] as String,
//         CapBac: json['CapBac'] as String,
//         SoBan: json['SoBan'] as int,
//         Sum: json['Sum'] as Object
//         );
        
//   }
// }
