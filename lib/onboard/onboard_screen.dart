import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sowlabs/login/login.dart';
import 'package:sowlabs/register/register.dart';

class IntroModel {
  final String title;
  final String description;
  final String image;
  final String buttonText;
  final Color bgColor;
  IntroModel({
    required this.title,
    required this.description,
    required this.image,
    required this.buttonText,
    required this.bgColor,
  });
}

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  List<IntroModel> introList = [
    IntroModel(
      title: "Quality",
      description:
          "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain. ",
      image: "assets/intor1.png",
      buttonText: "Join the movement!",
      bgColor: const Color(0xFF5EA25F),
    ),
    IntroModel(
      title: "Convenient",
      description:
          "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.",
      image: "assets/intor2.png",
      buttonText: "Join the movement!",
      bgColor: const Color(0xffD5715B),
    ),
    IntroModel(
      title: "Local",
      description:
          "We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time.",
      image: "assets/intro3.png",
      buttonText: "Join the movement!",
      bgColor: const Color(0xFFF8C569),
    ),
  ];

  PageController controller = PageController();
  double currentPageValue = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      currentPageValue = (currentPageValue + 1) % 3;
      controller.animateToPage(
        currentPageValue.toInt(),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });

    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: controller,
      itemCount: introList.length,
      itemBuilder: (context, index) {
        return Container(
          color: introList[index].bgColor,
          child: Column(
            children: [
              Image.asset(
                introList[index].image,
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    const SizedBox(height: 31),
                    Text(
                      introList[index].title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        introList[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    DotsIndicator(
                      dotsCount: 3,
                      position: currentPageValue.floor(),
                      reversed: false,
                      decorator: DotsDecorator(
                        color: Colors.black,
                        activeSize: const Size(30, 9),
                        activeColor: Colors.black,
                        size: const Size.square(9),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: introList[index].bgColor,
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Text(
                          introList[index].buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  ]),
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
