import 'package:country_list_app/core/routes/app_routes.dart';
import 'package:country_list_app/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;

      final username = usernameController.text.trim();

      final password = passwordController.text.trim();

      if (username.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Username dan Password wajib diisi");
        return;
      }

      await sharedPreferencesService.saveLogin(username, password);

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await sharedPreferencesService.logout();

    usernameController.clear();
    passwordController.clear();

    Get.offAllNamed(AppRoutes.login);
  }

  Future<bool> checkLogin() async {
    return await sharedPreferencesService.isLoggedIn();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
