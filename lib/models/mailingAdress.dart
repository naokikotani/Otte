import 'package:flutter/material.dart';

class MailingAddress {
  const MailingAddress({
    @required this.id,
    @required this.address1,
    @required this.address2,
    @required this.city,
    @required this.country,
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.province,
    @required this.zip,
  });

  final String id;
  final String address1;
  final String address2;
  final String city;
  final String country;
  final String firstName;
  final String lastName;
  final String phone;
  final String province;
  final String zip;
}
