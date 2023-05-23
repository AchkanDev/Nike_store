import 'package:flutter/material.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/source/auth_dataSource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/http_baseUrl.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _saveAuthTokens(authInfo);
    debugPrint(authInfo.accessToken);
  }

  @override
  Future<void> refreshToken() async {
    try {
      final AuthInfo authInfo = await dataSource.refreshToken(
          "def502002ec19a1a8d8d2241fb3f37b13c1ff9bfaa7b1094c6ac2d79db3c081ff5978d2a674ce0947bdcb8b06978349a78082e7fa6295062a84c94ebb37934c902c68d188ddea556a301da243059f9abb84ca5ff54ce7664573a87449cb6262c258fd095611d348a2513a1a8deb0bdd2b1e9970383edc6e2ca7adb71e5d5271cc95f7d877fb6b6d50cec564e6309558bd69499c644c206e92703d894817633db9f6dd6627e87707d0bd0fc9514e2965032da7d573186ec858a1c9617f2648cfebcfea5ecfe63cb234fc21131f0c744a5f9c0a436dc842f7f053b307e44b457fb12b24adbfb83171e8d35698657f105d66e9898b7226791ea438ea3ea2db92cdb9bcb8ce196fa88176ca9c077a5d72c665e03e156b49f5e7aa3d3b7dd7908a235339b229f5e1b15c42a1bfce2a6a0804e3198ebe081cf9bae6b53ce70f171204f7b15bc2dfb5fee354c88be70b10b697f66f9b15f92331bc50073e4c322ea1d17c1ae");
      debugPrint(authInfo.refreshToken);
      _saveAuthTokens(authInfo);
      // return dataSource.refreshToken(
      //     "def502002ec19a1a8d8d2241fb3f37b13c1ff9bfaa7b1094c6ac2d79db3c081ff5978d2a674ce0947bdcb8b06978349a78082e7fa6295062a84c94ebb37934c902c68d188ddea556a301da243059f9abb84ca5ff54ce7664573a87449cb6262c258fd095611d348a2513a1a8deb0bdd2b1e9970383edc6e2ca7adb71e5d5271cc95f7d877fb6b6d50cec564e6309558bd69499c644c206e92703d894817633db9f6dd6627e87707d0bd0fc9514e2965032da7d573186ec858a1c9617f2648cfebcfea5ecfe63cb234fc21131f0c744a5f9c0a436dc842f7f053b307e44b457fb12b24adbfb83171e8d35698657f105d66e9898b7226791ea438ea3ea2db92cdb9bcb8ce196fa88176ca9c077a5d72c665e03e156b49f5e7aa3d3b7dd7908a235339b229f5e1b15c42a1bfce2a6a0804e3198ebe081cf9bae6b53ce70f171204f7b15bc2dfb5fee354c88be70b10b697f66f9b15f92331bc50073e4c322ea1d17c1ae");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> register(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.register(username, password);
      debugPrint(authInfo.accessToken);
      _saveAuthTokens(authInfo);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _saveAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> loadTokens() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken);
    }
  }
}
