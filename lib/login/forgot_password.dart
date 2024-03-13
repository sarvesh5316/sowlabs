import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlabs/controller/auth_controller.dart';
import 'package:sowlabs/login/login.dart';
import 'package:sowlabs/widgets/custom_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthController vm = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (vm) {
      return Scaffold(
        body: Container(
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
                "Forgot Password?",
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
              CustomTextFormField(
                emailController: vm.phoneController,
                label: "Phone Number",
                keyboardType: TextInputType.number,
                widgetPrefix: const Icon(Icons.call),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  vm.forgetPassword();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color(0xffD5715B),
                    borderRadius: BorderRadius.circular(117),
                  ),
                  child: const Center(
                    child: Text(
                      "Send Code",
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
        ),
      );
    });
  }
}
