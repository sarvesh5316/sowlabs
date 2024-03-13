import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sowlabs/controller/auth_controller.dart';
import 'package:sowlabs/login/forgot_password.dart';
import 'package:sowlabs/register/register.dart';
import 'package:sowlabs/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController vm = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (vm) {
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
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Text(
                      "New here? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: const Text(
                        "  Create account",
                        style: TextStyle(
                          color: Color(0xffD5715B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                CustomTextFormField(
                    widgetPrefix: const Icon(Icons.alternate_email),
                    label: "Email",
                    emailController: vm.emailController),
                const SizedBox(height: 24),
                CustomTextFormField(
                  widgetPrefix: const Icon(Icons.lock_outline),
                  emailController: vm.passwordController,
                  obscureText: true,
                  label: "Password",
                  widgetSuffix: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ForgotPassword();
                      }));
                    },
                    child: const Text(
                      "Forgot",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffD5715B),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    if (vm.loader) {
                      return;
                    }
                    if (vm.emailController.text.isEmpty ||
                        vm.passwordController.text.isEmpty) {
                      Get.rawSnackbar(message: "Please fill all the fields");
                      return;
                    }
                    vm.login();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: const Color(0xffD5715B),
                      borderRadius: BorderRadius.circular(117),
                    ),
                    child: Center(
                      child: vm.loader == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "or login with",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff261C12).withOpacity(0.3),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11, horizontal: 33),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(117),
                          border: Border.all(
                            color: const Color(0xff000000).withOpacity(0.08),
                          ),
                        ),
                        child: SvgPicture.asset("assets/aple.svg")),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11, horizontal: 33),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(117),
                          border: Border.all(
                            color: const Color(0xff000000).withOpacity(0.08),
                          ),
                        ),
                        child: SvgPicture.asset("assets/facebook.svg")),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11, horizontal: 33),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(117),
                          border: Border.all(
                            color: const Color(0xff000000).withOpacity(0.08),
                          ),
                        ),
                        child: SvgPicture.asset("assets/google.svg")),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
