class UserModel {
  String? userName;
  String? email;
  String? phoneNumber;
  String? photoUrl;

  UserModel({this.userName, this.email, this.phoneNumber, this.photoUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['useName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['useName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}
