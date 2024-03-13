import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sowlabs/controller/auth_controller.dart';
import 'package:sowlabs/login/login.dart';
import 'package:sowlabs/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthController vm = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    List<Widget> buildPage = [
      _buildScreen1(),
      _buildScreen2(),
      const BuildScreen3(),
      const Widget3(),
    ];

    List<String> titles = [
      "Welcome!",
      "Farm Info",
      "Verification",
      "Business Hours",
    ];

    return Scaffold(
      body: PageView.builder(
          itemCount: 4,
          controller: controller,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Container(
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
                    const SizedBox(height: 22),
                    Text(
                      "Signup ${index + 1} of 4",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      titles[index],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildPage[index],
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (index == 0 &&
                                vm.nameController.text.isNotEmpty &&
                                vm.emailController.text.isNotEmpty &&
                                vm.phoneController.text.isNotEmpty &&
                                vm.passwordController.text.isNotEmpty &&
                                vm.confirmPasswordController.text.isNotEmpty &&
                                vm.passwordController.text ==
                                    vm.confirmPasswordController.text) {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            } else if (index == 1 &&
                                vm.businessNameController.text.isNotEmpty &&
                                vm.informalNameController.text.isNotEmpty &&
                                vm.addressController.text.isNotEmpty &&
                                vm.cityController.text.isNotEmpty &&
                                vm.zipController.text.isNotEmpty) {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            } else if (index == 2 && vm.files.isNotEmpty) {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            } else if (index == 3 &&
                                vm.selectedDays.isNotEmpty) {
                              vm.register();
                            } else {
                              Get.rawSnackbar(
                                  message: "Please fill all the fields");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 66),
                            decoration: BoxDecoration(
                              color: const Color(0xffD5715B),
                              borderRadius: BorderRadius.circular(117),
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildScreen1() {
    return GetBuilder<AuthController>(builder: (vm) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 33),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(117),
                    border: Border.all(
                      color: const Color(0xff000000).withOpacity(0.08),
                    ),
                  ),
                  child: SvgPicture.asset("assets/aple.svg")),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 33),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(117),
                    border: Border.all(
                      color: const Color(0xff000000).withOpacity(0.08),
                    ),
                  ),
                  child: SvgPicture.asset("assets/facebook.svg")),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 33),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(117),
                    border: Border.all(
                      color: const Color(0xff000000).withOpacity(0.08),
                    ),
                  ),
                  child: SvgPicture.asset("assets/google.svg")),
            ],
          ),
          const SizedBox(height: 32),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "or signup with",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 32),
          CustomTextFormField(
              widgetPrefix: const Icon(Icons.person),
              label: "Full Name",
              emailController: vm.nameController),
          const SizedBox(height: 24),
          CustomTextFormField(
              widgetPrefix: const Icon(Icons.alternate_email),
              emailController: vm.emailController,
              label: "Email Address"),
          const SizedBox(height: 24),
          CustomTextFormField(
              widgetPrefix: const Icon(Icons.phone_outlined),
              emailController: vm.phoneController,
              label: "Phone Number"),
          const SizedBox(height: 24),
          CustomTextFormField(
              obscureText: true,
              widgetPrefix: const Icon(Icons.lock_outline),
              emailController: vm.passwordController,
              label: "Password"),
          const SizedBox(height: 24),
          CustomTextFormField(
              obscureText: true,
              widgetPrefix: const Icon(Icons.lock_outline),
              emailController: vm.confirmPasswordController,
              label: "Re-enter Password"),
        ],
      );
    });
  }

  Widget _buildScreen2() {
    List<String> cities = [
      "Delhi",
      "Mumbai",
      "Kolkata",
      "Chennai",
      "Bangalore",
      "Hyderabad",
      "Ahmedabad",
      "Pune",
      "Surat",
      "Jaipur",
      "Lucknow",
      "Kanpur",
      "Nagpur",
      "Indore",
      "Thane",
      "Bhopal",
      "Patna",
      "Vadodara",
      "Ghaziabad",
      "Ludhiana",
      "Agra",
      "Nashik",
      "Faridabad",
      "Meerut",
      "Rajkot",
      "Vasai-Virar",
      "Varanasi",
      "Srinagar",
      "Aurangabad",
      "Dhanbad",
      "Amritsar",
      "Navi Mumbai",
      "Allahabad",
      "Ranchi",
      "Howrah",
      "Coimbatore",
      "Jabalpur",
      "Gwalior",
      "Vijayawada",
      "Jodhpur",
      "Madurai",
      "Raipur",
      "Kota",
      "Chandigarh",
      "Guwahati",
      "Solapur",
      "Bareilly",
      "Moradabad",
      "Mysore",
      "Gurgaon",
      "Aligarh",
      "Jalandhar",
      "Bhubaneswar",
      "Salem",
      "Warangal",
      "Guntur",
      "Bhiwandi",
      "Saharanpur",
      "Gorakhpur",
      "Bikaner",
      "Amravati",
      "Noida",
      "Jamshedpur",
      "Bhilai",
      "Cuttack",
      "Firozabad",
      "Kochi",
      "Nellore",
      "Bhavnagar",
      "Dehradun",
      "Durgapur",
      "Asansol",
      "Rourkela",
    ];

    return GetBuilder<AuthController>(builder: (context) {
      return Column(
        children: [
          CustomTextFormField(
              label: "Business Name",
              emailController: vm.businessNameController),
          const SizedBox(height: 24),
          CustomTextFormField(
              emailController: vm.informalNameController,
              label: "Informal Name"),
          const SizedBox(height: 24),
          CustomTextFormField(
              emailController: vm.addressController, label: "Street Address"),
          const SizedBox(height: 24),
          CustomTextFormField(
              emailController: vm.cityController, label: "City"),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // make a dropdown with same decoration as CustomTextFormField of cities
              SizedBox(
                height: 48,
                width: 126,
                child: DropdownButton(
                  value: vm.selectedCity,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: cities.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    vm.selectedCity = newValue!;
                    vm.update();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFormField(
                    emailController: vm.zipController, label: "Enter Zipcode"),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class BuildScreen3 extends StatefulWidget {
  const BuildScreen3({super.key});

  @override
  State<BuildScreen3> createState() => _BuildScreen3State();
}

class _BuildScreen3State extends State<BuildScreen3> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (vm) {
      return Column(
        children: [
          const Text(
              "Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          const SizedBox(height: 57),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Attach proof of registration",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              InkWell(
                onTap: () {
                  vm.uploadFile();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xffD5715B),
                    borderRadius: BorderRadius.circular(117),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          ...vm.files.map((e) {
            return Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff261C12).withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      e.path.split("/").last,
                      style: const TextStyle(),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close))
                ],
              ),
            );
          }).toList(),
        ],
      );
    });
  }
}

class Widget3 extends StatefulWidget {
  const Widget3({super.key});

  @override
  State<Widget3> createState() => _Widget3State();
}

class _Widget3State extends State<Widget3> {
  List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];
  List<String> timimg = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm"
  ];
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (vm) {
      return Column(
        children: [
          Text(
            "Choose the hours your farm is open for pickups. This will allow customers to order deliveries.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              return Container(
                height: 36,
                width: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: (selectedTime.weekday - 1) == index
                      ? const Color(0xffD5715B)
                      : selectedTime.weekday < index
                          ? const Color(0xff261C12).withOpacity(0.3)
                          : const Color(0xFfffffff),
                  border: Border.all(
                    color: const Color(0xff000000).withOpacity(0.08),
                  ),
                ),
                child: Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 16,
                    color: (selectedTime.weekday - 1) == index
                        ? Colors.white
                        : selectedTime.weekday > index
                            ? Colors.black
                            : const Color(0xff261C12).withOpacity(0.3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),
          ...List.generate(
            (timimg.length / 2).ceil(),
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimimgWidget(
                      ontap: () {
                        print("pppppppppp");
                        setState(() {
                          if (vm.selectedDays.contains(timimg[2 * index])) {
                            vm.selectedDays.remove(timimg[2 * index]);
                          } else {
                            vm.selectedDays.add(timimg[2 * index]);
                          }
                        });
                        print("selectedDays: ${vm.selectedDays.length}");
                      },
                      text: timimg[2 * index],
                      color: vm.selectedDays.contains(timimg[2 * index])
                          ? const Color(0xffF8C569)
                          : const Color(0xff261C12).withOpacity(0.1),
                    ),
                    if (2 * index + 1 < timimg.length)
                      TimimgWidget(
                        ontap: () {
                          setState(() {
                            if (vm.selectedDays
                                .contains(timimg[2 * index + 1])) {
                              vm.selectedDays.remove(timimg[2 * index + 1]);
                            } else {
                              vm.selectedDays.add(timimg[2 * index + 1]);
                            }
                          });
                        },
                        text: timimg[2 * index + 1],
                        color: vm.selectedDays.contains(timimg[2 * index + 1])
                            ? const Color(0xffF8C569)
                            : const Color(0xff261C12).withOpacity(0.1),
                      ),
                  ],
                ),
              );
            },
            growable: false,
          ),
        ],
      );
    });
  }
}

class TimimgWidget extends StatefulWidget {
  const TimimgWidget({
    super.key,
    required this.color,
    required this.text,
    this.ontap,
  });

  final Color color;
  final String text;
  final Function()? ontap;

  @override
  State<TimimgWidget> createState() => _TimimgWidgetState();
}

class _TimimgWidgetState extends State<TimimgWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
