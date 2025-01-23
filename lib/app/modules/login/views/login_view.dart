import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: loginController.loginFormKey,
        child: Obx(
          () => loginController.isLoading.value
              ? Center(
                  child: Text('Loading'),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: loginController.companyCodeController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'youeemail@email.com',
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            //Handle empty field
                            return "Please enter the username. This can be your company code as well.";
                          } else {
                            //Regex for email
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return "Please enter a valid email";
                            }
                          }
                          return null;
                        },
                        onChanged: (value) {
                          loginController.validateForm();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: loginController.passwordController,
                          obscureText: loginController.passwordObscured.value,
                          decoration: InputDecoration(
                            hintText: '********',
                            labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginController.flipPasswordFieldVisibility();
                              },
                              icon: loginController.passwordObscured.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              //Handle empty field
                              return "Please provide a password";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            loginController.validateForm();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                loginController.onLoginTapped();
                              },
                              child: const Text('Sign In'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
