import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/const/color.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/bg1.jpg'),
              fit: BoxFit.fill, // Use BoxFit.fill to cover the full screen
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // Add opacity to the image
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                Image.asset(
                  'assets/images/security.png',
                  height: 175,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixIcon:
                                Icon(Icons.email, color: Colors.white70),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _loading ? null : _submit,
                          child: _loading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Reset Password',
                                  style: TextStyle(color: bg, fontSize: 18),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _submit() async {
    String email = _emailController.text;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Password Reset Email has been sent !",
              style: TextStyle(fontSize: 20.0),
            ),
            backgroundColor: Color.fromARGB(255, 77, 81, 79),
          ));
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (mounted) {
          if (e.code == "user-not-found") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "No user found for that email.",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Something went wrong!!",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          }
        }
      }
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _loading = false;
        });

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: const Text('Password Reset'),
        //       content: const Text('An email with instructions has been sent.'),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     );
        //   },
        // );
      });
    }
  }
}
