import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:user_crud/model/user.dart';

class UserApi {
  static const _url = 'http://10.0.2.2:3056/user/';

  static Future<List<User>> fetchUsers () async {
    const url = _url;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['metadata'] as List<dynamic>;
    final users = result.map((e) {
      return User(
        email:e['email'],
        name:e['name'],
        image:e['image'],
        id:e['_id'],
      );
    }).toList();
    return users;
  }

  static Future<String> createUser (name,email,password) async {

    final request = {
      'name': name,
      'email': email,
      'password': password
    };
    const url = _url;
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(request),
      headers: {
        "Content-Type": "application/json",
      }
    );

    // final<Map> result = response.body;
    // List<User> users = [];
    Map<String,dynamic> result = jsonDecode(response.body);
    String status = result['status'].toString();
    return status;
  }

  static Future<Map> detailUser (id) async {
    const url = _url;
    final uri = Uri.parse(url+id);
    final response = await http.get(uri);

    Map<String,dynamic> result = jsonDecode(response.body);

    return result;
  }

  static Future<Map> updateUser (id, name,password) async {

    final request = {
      '_id': id,
      'name': name,
      'password': password
    };
    const url = _url;
    final uri = Uri.parse(url);

    final response = await http.patch(
      uri,
      body: jsonEncode(request),
      headers: {
        "Content-Type": "application/json",
      }
    );

    Map<String,dynamic> result = jsonDecode(response.body);

    return result;
  }

  static Future<String> uploadImage (id, imageFile) async {
    const url = 'http://10.0.2.2:3056/upload-image';
    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST',uri);
    request.fields['_id'] = id.toString();
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();


    return response.statusCode.toString();
  }

  static Future<String> deleteUser (id) async {
    final request = {
      '_id': id,
    };
    const url = _url;
    final uri = Uri.parse(url);
    final response = await http.delete(
        uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
        }
    );
    Map<String,dynamic> result = jsonDecode(response.body);
    String status = result['status'].toString();
    return status;
  }
}