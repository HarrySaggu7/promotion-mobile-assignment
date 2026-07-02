import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Login Clicked");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(AppSpacing.lg),

          child: Form(

            key: _formKey,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Spacer(),

                Text(
                  AppStrings.appName,
                  style: AppTextStyles.heading1,
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  "Welcome Back!",
                  style: AppTextStyles.caption,
                ),

                const SizedBox(height: AppSpacing.xl),

                AppTextField(
                  controller: emailController,
                  label: AppStrings.email,
                ),

                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  controller: passwordController,
                  label: AppStrings.password,
                  obscureText: true,
                ),

                const SizedBox(height: AppSpacing.lg),

                AppButton(
                  text: AppStrings.login,
                  onPressed: login,
                ),

                const SizedBox(height: AppSpacing.sm),

                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(AppStrings.continueAsGuest),
                  ),
                ),

                const Spacer(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}