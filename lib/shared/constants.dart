import 'package:flutter/material.dart';

final inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
  filled: true,
  fillColor: Colors.white,
);

const SAVE_KEY_NAME = 'UserLoggedIn';
