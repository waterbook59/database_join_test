import 'package:flutter/material.dart';

///DB保存用クラスProductRecordImageはdata_models内に作らない

class ProductImage {
//  final int productId;
//  final int imageId;
  final String small;
  final String medium;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  // ignore: sort_constructors_first
  const ProductImage({
    @required this.small,
    @required this.medium,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ProductImage &&
              runtimeType == other.runtimeType &&
              small == other.small &&
              medium == other.medium);

  @override
  int get hashCode => small.hashCode ^ medium.hashCode;

  @override
  String toString() {
    return 'ProductImage{${' small: $small,'}${' medium: $medium,'}}';
  }

  ProductImage copyWith({
    String small,
    String medium,
  }) {
    return  ProductImage(
      small: small ?? this.small,
      medium: medium ?? this.medium,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'small': small,
      'medium': medium,
    };
  }

  // ignore: sort_constructors_first
  factory ProductImage.fromMap(Map<String, dynamic> map) {
    return  ProductImage(
      small: map['small'] as String,
      medium: map['medium'] as String,
    );
  }

//</editor-fold>
}



