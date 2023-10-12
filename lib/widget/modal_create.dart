import 'package:flutter/material.dart';
import 'package:user_crud/services/user_api.dart';

class ModalBottom extends StatelessWidget {
  ModalBottom( {
    super.key, required this.fetchUsers

  });


  final Future<void> fetchUsers;

  String name = '';
  String email = '';
  String password = '';
  
  void _handleOnClick (BuildContext context) async {
    if(name.isEmpty || email.isEmpty || password.isEmpty) {
      return;
    }
    final status = await UserApi.createUser(name,email,password);

    if(status == '200') {
      fetchUsers;
      Navigator.pop(context);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(

          padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  name = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tên người dùng'
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                 onChanged: (text) {
                   email = text;
                 },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email'
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  password = text;
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mật khẩu'
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed:() => _handleOnClick(context),
                  child: const Text ('Thêm người dùng'))
            ],
          ),
        ),
      ),
    );
  }

}
