
class Login_Request {
  String? username;
  String? password;
  String? device_name;

  Login_Request({this.username, this.password, this.device_name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['device_name'] = this.device_name;
    return data;
  }
}
