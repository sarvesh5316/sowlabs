// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlabs/login/reset_password.dart';
import 'package:sowlabs/login/succes.dart';
import 'package:sowlabs/login/verify_otp.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController informalNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  String selectedCity = "Delhi";

  List<String> selectedDays = [];

  bool loader = false;

  String token = "";

  List<File> files = [];
  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      update();
    } else {}
  }

  void removeFile(int index) {
    files.removeAt(index);
    update();
  }

  void register() async {
    print("Registering");
    loader = true;
    update();

    dio.Dio dioInstance = dio.Dio();
    Map<String, dynamic> map = {
      "full_name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "password": passwordController.text,
      "role": "farmer",
      "address": addressController.text,
      "business_name": businessNameController.text,
      "informal_name": informalNameController.text,
      "city": cityController.text,
      "zip_code": zipController.text,
      "business_hours": {
        "mon": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "tue": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "wed": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
        "thu": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
        "fri": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "sat": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "sun": ["8:00am -10:00am"]
      },
      "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      "type": "email/facebook/google/apple",
      "social_id": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
    };

    var formData = dio.FormData.fromMap(map);
    formData.files.add(MapEntry(
        "registration_proof", dio.MultipartFile.fromString(files[0].path)));

    try {
      var response = await dioInstance
          .post("https://sowlab.pw/assignment/user/register", data: map);
      if (response.data != null) {
        Get.rawSnackbar(message: response.data["message"]);
      }
      if (response.data != null && response.data["success"]) {
        Get.to(() => const SuccessPage());
      }
    } catch (e) {
      print(e);
    }
    loader = false;
    update();
  }

  void login() async {
    print("Logging in");
    loader = true;
    update();

    dio.Dio dioInstance = dio.Dio();
    Map<String, dynamic> map = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      "type": "email/facebook/google/apple",
      "social_id": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      "role": "farmer",
    };

    try {
      var response = await dioInstance
          .post("https://sowlab.pw/assignment/user/login", data: map);
      print(response.data);
      if (response.data != null) {
        Get.rawSnackbar(message: response.data["message"]);
      }
      if (response.statusCode == 200 && response.data["success"]) {
        token = response.data["token"];
        update();
      }
    } catch (e) {
      Get.rawSnackbar(message: "Error while Logging in");
      print(e);
    }
    loader = false;
    update();
  }

  void forgetPassword() async {
    print("Forget Password");
    loader = true;
    update();

    dio.Dio dioInstance = dio.Dio();
    Map<String, dynamic> map = {
      "mobile": "+91${phoneController.text}",
    };

    try {
      var response = await dioInstance
          .post("https://sowlab.pw/assignment/user/forgot-password", data: map);
      print(response.data);
      if (response.data != null) {
        Get.rawSnackbar(message: response.data["message"]);
      }
      if (response.statusCode == 200 && response.data["success"]) {
        Get.to(() => const VerifyOtpPage());
      }
    } catch (e) {
      Get.rawSnackbar(message: "Error while Sending OTP");
      print(e);
    }
    loader = false;
    update();
  }

  String otp = "";

  void verifyOtp() async {
    print("Reset Password :  $otp");
    loader = true;
    update();

    dio.Dio dioInstance = dio.Dio();
    Map<String, dynamic> map = {
      "otp": "895642",
    };

    try {
      var response = await dioInstance
          .post("https://sowlab.pw/assignment/user/verify-otp", data: map);
      print(response.data);
      if (response.data != null) {
        Get.rawSnackbar(message: response.data["message"]);
      }
      if (response.statusCode == 200 && response.data["success"]) {
        Get.to(() => ResetPassword(token: response.data["token"]));
      }
    } catch (e) {
      Get.rawSnackbar(message: "Error while Verifying OTP");
      print(e);
    }
    loader = false;
    update();
  }

  void resetPassword(String token) async {
    print("Reset Password");
    loader = true;
    update();

    dio.Dio dioInstance = dio.Dio();
    Map<String, dynamic> map = {
      "password": passwordController.text,
      "cpassword": confirmPasswordController.text,
      "token": token,
    };

    try {
      var response = await dioInstance
          .post("https://sowlab.pw/assignment/user/reset-password", data: map);
      print(response.data);
      if (response.data != null) {
        Get.rawSnackbar(message: response.data["message"]);
      }
      if (response.statusCode == 200 && response.data["success"]) {
        Get.to(() => const SuccessPage());
      }
    } catch (e) {
      print(e);
    }
    loader = false;
    update();
  }
}
