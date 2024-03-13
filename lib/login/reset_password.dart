import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlabs/controller/auth_controller.dart';
import 'package:sowlabs/login/login.dart';
import 'package:sowlabs/widgets/custom_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.token});

  final String token;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthController vm = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              const Text(
                "FarmerEats",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 90),
              const Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => Get.to(() => const LoginScreen()),
                child: RichText(
                    text: const TextSpan(
                  text: "Remember your pasword? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "  Login",
                      style: TextStyle(
                        color: Color(0xffD5715B),
                      ),
                    ),
                  ],
                )),
              ),
              const SizedBox(height: 72),
              CustomTextFormField(emailController: vm.passwordController),
              const SizedBox(height: 24),
              CustomTextFormField(
                  emailController: vm.confirmPasswordController),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  vm.resetPassword(widget.token);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color(0xffD5715B),
                    borderRadius: BorderRadius.circular(117),
                  ),
                  child: const Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
