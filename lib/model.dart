import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? phone;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.phone, this.email, this.profilepic});

  // UserModel.fromMap(Map<String, dynamic> map) {
  //   uid = map["uid"];
  //   phone = map["phone"];
  //   email = map["email"];

  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "uid": uid,
  //     "phone": phone,
  //     "email": email,

  //   };
  // }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      profilepic: json['profilepic'] as String,
    );
  }
  toJson() {
    return UserModel(
      uid: 'uid',
      phone: 'phone',
      email: 'email',
      profilepic: 'profilepic',
    );
  }

  UserModel copyWith({
    String? uid,
    String? phone,
    String? email,
    String? profilepic,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      profilepic: profilepic ?? this.profilepic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'phone': phone,
      'email': email,
      'profilepic': profilepic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profilepic:
          map['profilepic'] != null ? map['profilepic'] as String : null,
    );
  }
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documnet) {
    final data = documnet.data()!;
    return UserModel(
      uid: documnet.id,
      email: data['email'],
      phone: data['phone'],
      profilepic: data['profilepic'],
    );
  }

  // }
  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return UserModel(
  //     uid: document.id,
  //     email: data["Email"],
  //     phone: data["phone"],
  //     profilepic: data["profilepic"],
  //   );
  // }

  //  String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, phone: $phone, email: $email, profilepic: $profilepic)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.phone == phone &&
        other.email == email &&
        other.profilepic == profilepic;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ phone.hashCode ^ email.hashCode ^ profilepic.hashCode;
  }
}

// class RoomModel {
//   String? uid;
//   String? imageUrl;
//   String? price;
//   String? address;

//   RoomModel({this.uid, this.imageUrl, this.price, this.address});
//   RoomModel copyWith({
//     String? uid,
//     String? imageUrl,
//     String? price,
//     String? address,
//   }) {
//     return RoomModel(
//       uid: uid ?? this.uid,
//       imageUrl: imageUrl ?? this.imageUrl,
//       price: price ?? this.price,
//       address: address ?? this.address,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'uid': uid,
//       'imageUrl': imageUrl,
//       'price': price,
//       'address': address,
//     };
//   }

//   factory RoomModel.fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> document) {
//     final info = document.data()!;
//     return RoomModel(
//       uid: document.id,
//       imageUrl: info['imageUrl'],
//       price: info['price'],
//       address: info['address'],
//     );
//   }

//   // factory RoomModel.fromSnapshot(
//   //     DocumentSnapshot<Map<String, dynamic>> document) {
//   //   final data = document.data()!;
//   //   return RoomModel(
//   //    uid: document.id,
//   //    imageUrl: data['imageUrl'],
//   //    price: data['price'],
//   //    address: data[]
//   //   );
//   // }

//   factory RoomModel.fromMap(Map<String, dynamic> map) {
//     return RoomModel(
//       uid: map["uid"] != null ? map["uid"] as String : null,
//       imageUrl: map["imageUrl"] != null ? map["imageUrl"] as String : null,
//       price: map["price"] != null ? map["price"] as String : null,
//       address: map["addrress"] != null ? map["address"] as String : null,
//     );
//   }
//   String toJson() => jsonEncode(toMap());
//   factory RoomModel.fromJson(String source) =>
//       RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
//   @override
//   String toString() {
//     return 'RoomModel(uid: $uid, imageUrl: $imageUrl, price: $price, address: $address)';
//   }

//   @override
//   bool operator ==(covariant RoomModel other) {
//     if (identical(this, other)) return true;
//     return other.uid == uid &&
//         other.imageUrl == imageUrl &&
//         other.address == address &&
//         other.price == price;
//   }

//   @override
//   int get hashCode {
//     return uid.hashCode ^ imageUrl.hashCode ^ price.hashCode ^ address.hashCode;
//   }
// }
