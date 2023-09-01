import 'package:flutter/material.dart';
import 'package:framework_e_commerce/ui/pages/login/login.presenter.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  final LoginPagePresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.presenter.navigateToStream.listen((page) {
      if (page?.isNotEmpty == true) {
        Get.offAllNamed(page!,
            arguments: widget.presenter.navigationHomePage());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5F3473), // Cor principal para frutas
        title: Text(
          'hortifruit_framework'.tr,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_florist, // Ícone de frutas do Flutter
              color: Color(0xFF5F3473),
              size: 120,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'enter_your_email'.tr,
                prefixIcon: const Icon(Icons.email, color: Color(0xFF5F3473)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                hintText: 'enter_your_password'.tr,
                prefixIcon: const Icon(Icons.lock, color: Color(0xFF5F3473)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                widget.presenter.loginWithEmailAndPassword(email, password);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF5F3473),
                ),
              ),
              child: Text(
                'login'.tr,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _showRegisterDialog(
                    context, widget.presenter); // Exibe o popup de registro
              },
              child: Text(
                'register_new_account'.tr,
                style: const TextStyle(
                  color: Color(0xFF5F3473),
                ),
              ),
            ),
            Obx(() {
              final error = widget.presenter.error.value;
              return error != null
                  ? Text(
                      error,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}

Future<void> _showRegisterDialog(
    BuildContext context, LoginPagePresenter presenter) async {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Registrar nova conta'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'password'.tr),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              final email = emailController.text;
              final password = passwordController.text;
              await presenter.registerWithEmailAndPassword(email, password);
              Future.delayed(const Duration(milliseconds: 2000));
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: Text('register'.tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('cancel'.tr),
          ),
        ],
      );
    },
  );
}
