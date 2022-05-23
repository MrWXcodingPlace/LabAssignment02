import 'package:ecoshop/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //调整screen的，意义不明
  late double screenHeight, screenWidth, ctrwidth;

  //For rememver checkbox usage
  bool remember = false;

  //Input for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //意义不明
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    //暂时不明
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: ctrwidth,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Logo ecoshop
                        SizedBox(
                          height: screenHeight / 2.5,
                          width: screenWidth,
                          child: Image.asset("assets/images/logo.png"),
                        ),

                        //The Page Title (Login)
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),

                        // Email TextField Column bar
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),

                          //验证方式
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid email';
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);

                            if (!emailValid) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        //Break Line
                        const SizedBox(
                          height: 10,
                        ),

                        // Password TextField Column bar
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),

                          //验证密码
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),

                        //Remember me Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: remember,
                              //Remeber me的操作，不明白
                              onChanged: (bool? value) {
                                _onRememberMeChanged(value!);
                              },
                            ),
                            const Text("Remeber Me"),
                          ],
                        ),

                        //Login Button
                        SizedBox(
                          width: screenWidth,
                          height: 50,
                          child: ElevatedButton(
                            child: const Text("Login"),
                            onPressed: _loginUser,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onRememberMeChanged(bool value) {
    setState(() {
      remember = value;
    });
  }

  void _loginUser() {
    String _email = _emailController.text;
    String _password = _passwordController.text;
    print(_email);
    print(_password);
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.post(
          Uri.parse("http://192.168.43.56/ecoshop/mobile/php/login_admin.php"),
          body: {"email": _email, "password": _password}).then((response) {
        print(response.body);
      });
    }
  }
}
