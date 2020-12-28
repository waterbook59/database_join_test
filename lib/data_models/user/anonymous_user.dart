import 'package:flutter/material.dart';

class AnonymousUser{
  final String userId;
  final String displayName;//Firebaseに登録したユーザー情報に紐づいたユーザー名
  final String inAppUserName;//アプリ内で編集できるユーザー名(初期はdisplayNameと同じ)
  final String photoUrl;// 家族アイコン？

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  // ignore: sort_constructors_first
  const AnonymousUser({
    @required this.userId,
    @required this.displayName,
    @required this.inAppUserName,
    @required this.photoUrl,
  });

@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is AnonymousUser &&
              runtimeType == other.runtimeType &&
              userId == other.userId &&
              displayName == other.displayName &&
              inAppUserName == other.inAppUserName &&
              photoUrl == other.photoUrl
          );


  @override
  int get hashCode =>
      userId.hashCode ^
      displayName.hashCode ^
      inAppUserName.hashCode ^
      photoUrl.hashCode;


  @override
  String toString() {
    return 'AnonymousUser{${' userId: $userId,'
    }${' displayName: $displayName,'
    }${' inAppUserName: $inAppUserName,'}${' photoUrl: $photoUrl,'}}';
  }


  AnonymousUser copyWith({
    String userId,
    String displayName,
    String inAppUserName,
    String photoUrl,
  }) {
    return AnonymousUser(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      inAppUserName: inAppUserName ?? this.inAppUserName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }


  Map<String, dynamic> toMap() {
    return <String,dynamic>{
      'userId': userId,
      'displayName': displayName,
      'inAppUserName': inAppUserName,
      'photoUrl': photoUrl,
    };
  }

  // ignore: sort_constructors_first
  factory AnonymousUser.fromMap(Map<String, dynamic> map) {
    return  AnonymousUser(
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      inAppUserName: map['inAppUserName'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }
  
  //</editor-fold>

}