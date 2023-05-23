import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store/data/repo/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _usernameController =
      TextEditingController(text: "test@gmail.com");
  TextEditingController _passwordController =
      TextEditingController(text: "123456");
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(theme.colorScheme.onBackground),
                  foregroundColor:
                      MaterialStatePropertyAll(theme.colorScheme.background),
                  minimumSize:
                      const MaterialStatePropertyAll(Size.fromHeight(56)))),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: theme.colorScheme.onBackground),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: theme.colorScheme.onBackground, width: 1),
                borderRadius: BorderRadius.circular(12),
              ))),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/nike_logo.png",
                    height: 50,
                    color: theme.colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(isLogin ? "خوش آمدید" : "ثبت نام"),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(isLogin
                      ? "لطفا حساب کاربری خود را وارد کنید"
                      : "ایمیل و رمز عبور خود را تعیین کنید"),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text("آدرس ایمیل"),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    onBackground: theme.colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // authRepository.refreshToken();
                        authRepository.login(
                            _usernameController.text, _passwordController.text);
                      },
                      child: Text(isLogin ? "ورود" : "ثبت نام")),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isLogin
                            ? "حساب کاربری ندارید؟"
                            : "حساب کاربری دارید؟"),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          isLogin ? "ثبت نام " : "ورود",
                          style: TextStyle(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final Color onBackground;
  const PasswordTextField({
    super.key,
    required this.onBackground,
    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obsureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      obscureText: obsureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: obsureText
              ? const Icon(Icons.visibility_outlined)
              : const Icon(Icons.visibility_off_outlined),
          color: widget.onBackground,
          onPressed: () {
            setState(() {
              obsureText = !obsureText;
            });
          },
        ),
        label: const Text("پسورد"),
      ),
    );
  }
}
