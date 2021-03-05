import 'package:flutter/material.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Common/CommonWidget.dart';
import 'package:shoppy_seller/Services/AuthService.dart';
import 'package:shoppy_seller/validator.dart';

class UserResistration extends StatefulWidget {
  @override
  _UserResistrationState createState() => _UserResistrationState();
}

class _UserResistrationState extends State<UserResistration> {
  String password;
  String email;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Builder(
        builder: (co) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: CommonAssets.de.copyWith(
                      hintText: "Email ",
                    ),
                    onChanged: (val) => email = val,
                    validator: validator.ValidateEmail,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: CommonAssets.de.copyWith(
                      hintText: "Password ",
                    ),
                    onChanged: (val) => password = val,
                    validator: (val) => val.isEmpty ? "Enter Password" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonWidget.getRaisedButton(
                      text: "Register",
                      function: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String res = await AuthService()
                            .RegisterWithEmailAndPassword(email, password);
                        print(res);
                        if (res == "Done") {
                          Navigator.pop(context);
                          return;
                        }
                        SnackBar s = SnackBar(
                          content: Text(res),
                        );
                        Scaffold.of(co).showSnackBar(s);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      context: context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
