class Producttype{
  final String? id;
  final String proT_Code;
  final String proT_Name;
  final String proT_describe;

  Producttype({
    this.id,
    required this.proT_Code,
    required this.proT_Name,
    required this.proT_describe,
  });

  Producttype coppyWith({
    String? id,
    String? proT_Code,
    String? proT_Name,
    String? proT_describe,
  }){
    return Producttype(
      id: id ?? this.id,
      proT_Code: proT_Code ?? this.proT_Code,
      proT_Name: proT_Name ?? this.proT_Name,
      proT_describe: proT_describe ?? this.proT_describe,
    );
  }

  static Producttype fromJson(Map<String, dynamic> json){
    return Producttype(
      id: json['_id'],
      proT_Code : json['proT_Ma'],
      proT_Name: json['proT_Ten'],
      proT_describe: json['proT_MoTa'],
    );
  }
  Map<String, dynamic> toJson(String? id){
    return {
      'id':id,
      'proT_Ma' : proT_Code,
      'proT_Ten' : proT_Name,
      'proT_MoTa' : proT_describe
    };
  }
}