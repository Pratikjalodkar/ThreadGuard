import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/google_login.dart';
import 'package:myapp/const/color.dart';
import 'package:myapp/screens/login%20sigup%20screen/login_screen.dart';
import 'package:myapp/screens/nav%20screens/mainscreen.dart';
import 'package:myapp/sevices/auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  String email = "", password = "", name = "";

  registration() async {
    if (_passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        print("User created: ${userCredential.user?.email}");
        await userCredential.user?.sendEmailVerification();

        print("Email verification sent to: ${userCredential.user?.email}");
        // if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Registration link is send to your email address",
            style: TextStyle(fontSize: 20.0),
          ),
          backgroundColor: Color.fromARGB(255, 77, 81, 79),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        // }
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        String errorMessage;

        if (e.code == 'weak-password') {
          print(e.code);
          errorMessage = 'Make a strong password!';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Email already exists';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is invalid';
        } else if (e.code == 'operation-not-allowed') {
          errorMessage = 'Error!';
        } else {
          errorMessage = 'Error!';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: TextStyle(fontSize: 18.0),
            ),
            backgroundColor: Color.fromARGB(255, 77, 81, 79),
          ),
        );

        // if (e.code == 'weak-password') {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //       backgroundColor: bg,
        //       content: Text(
        //         "Password Provided is too Weak",
        //         style: TextStyle(fontSize: 18.0),
        //       )));
        // } else if (e.code == "email-already-in-use") {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //       backgroundColor: bg,
        //       content: Text(
        //         "Account Already exists",
        //         style: TextStyle(fontSize: 18.0),
        //       )));
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/bg1.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/security.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Center(
                        child: Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.person, color: Colors.white70),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.email, color: Colors.white70),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email or username';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white70),
                          prefixIcon:
                              const Icon(Icons.key, color: Colors.white70),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(color: Colors.white70),
                          prefixIcon:
                              const Icon(Icons.key, color: Colors.white70),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = _emailController.text;
                              name = _nameController.text;
                              password = _passwordController.text;
                            });
                          }
                          registration();
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: bg, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'or continue with',
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AuthMethods().signInWithGoogle(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              Colors.white, // Change the text color as needed
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: 30,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Log in with Google',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      // GoogleSignInButton(onPressed: () {}),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          // Navigate to login screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              ' Log In',
                              style: TextStyle(color: Colors.blue.shade300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
