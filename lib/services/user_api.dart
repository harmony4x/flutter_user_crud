import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:user_crud/model/user.dart';

import '../configs/api_config.dart';

class UserApi {
  static final _url = ApiConfig.apiBaseUrl;


  static Future<List<User>> fetchUsers () async {

    final url = _url;
    final uri = Uri.parse(url+'user');
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
    final url = _url;
    final uri = Uri.parse(url+'user');
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
    final url = _url;
    final uri = Uri.parse(url+'user/'+id);
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
    final url = _url;
    final uri = Uri.parse(url+'user');

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
    final url = _url;
    final uri = Uri.parse('${url}upload-image');
    print('$uri url o day ne');
    var request = http.MultipartRequest('POST',uri);
    request.fields['_id'] = id.toString();
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();


    return response.statusCode.toString();
  }

  static Future<Map> uploadImageInWeb (id, imageBytes) async {
    String base64Image = base64Encode(imageBytes);

    final request = {
      '_id': id,
      'image': base64Image,
    };
    final url = _url;
    final uri = Uri.parse('${url}upload-image2');
    final response = await http.post(
        uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
        }
    );
    Map<String,dynamic> result = jsonDecode(response.body);


    return result;
  }

  static Future<String> deleteUser (id) async {
    final request = {
      '_id': id,
    };
    final url = _url;
    final uri = Uri.parse(url+'user');
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