// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  int? adminSystem;
  String? username;
  String? email;
  String? mobileNo;
  int? roleId;
  int? isActive;
  String? userAddresss;
  String? deviceToken;
  int? userLat;
  int? userLng;
  String? imagePath;

  User({
    this.id,
    this.adminSystem,
    this.username,
    this.email,
    this.mobileNo,
    this.roleId,
    this.isActive,
    this.userAddresss,
    this.deviceToken,
    this.userLat,
    this.userLng,
    this.imagePath,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        adminSystem: json["admin_system"],
        username: json["username"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        roleId: json["role_id"],
        isActive: json["is_active"],
        userAddresss: json["user_addresss"],
        deviceToken: json["device_token"],
        userLat: json["user_lat"],
        userLng: json["user_lng"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_system": adminSystem,
        "username": username,
        "email": email,
        "mobile_no": mobileNo,
        "role_id": roleId,
        "is_active": isActive,
        "user_addresss": userAddresss,
        "device_token": deviceToken,
        "user_lat": userLat,
        "user_lng": userLng,
        "image_path": imagePath,
      };
}
