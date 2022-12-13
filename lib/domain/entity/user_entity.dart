import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserEntity {

  final String id;
  String firstName;
  String lastName;
  final String phoneNumber;
  String email;
  String address;
  String url;


  UserEntity({this.id = '0', this.firstName = '', this.lastName = '',this.phoneNumber ='',this.email = '',this.address = '',this.url = ''});

  Map<String, dynamic> toJson() => {
    'data': {
      'id': int.parse(id),
      'phoneNumber' : phoneNumber,
      'firstName' :firstName,
      'lastName' : lastName,
      'email' :email,
      'address': address,
      'url' : url
    },
    "meta":{}
  };


  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return UserEntity(
        id: json['id'].toString(),
        firstName: attributes['firstName'] as String,
        lastName:  attributes['lastName'] as String,
        phoneNumber: attributes['phoneNumber'] as String,
        email:  attributes['email'] as String,
        address:  attributes['address'] as String,
        url: attributes['url'] ?? ''
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return """ 
    ID: $id
    FirstName :$firstName
    LastName :$lastName
    Phone:$phoneNumber
    Email:$email
    Address:$address
    url:$url}
    """;
  }
}
