// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsersModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? idCard;
  String? profile;
  String? role;
  String? status;
  int? createdAt;
  String? address;
  UsersModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.idCard,
    this.profile,
    this.role,
    this.status,
    this.createdAt,
    this.address,
  });

  UsersModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? idCard,
    String? profile,
    String? role,
    String? status,
    int? createdAt,
    String? address,
  }) {
    return UsersModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      idCard: idCard ?? this.idCard,
      profile: profile ?? this.profile,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'idCard': idCard,
      'profile': profile,
      'role': role,
      'status': status,
      'createdAt': createdAt,
      'address': address,
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      idCard: map['idCard'] != null ? map['idCard'] as String : null,
      profile: map['profile'] != null ? map['profile'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersModel.fromJson(String source) =>
      UsersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UsersModel(id: $id, name: $name, email: $email, phone: $phone, idCard: $idCard, profile: $profile, role: $role, status: $status, createdAt: $createdAt, address: $address)';
  }

  @override
  bool operator ==(covariant UsersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.idCard == idCard &&
        other.profile == profile &&
        other.role == role &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        idCard.hashCode ^
        profile.hashCode ^
        role.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        address.hashCode;
  }
}
