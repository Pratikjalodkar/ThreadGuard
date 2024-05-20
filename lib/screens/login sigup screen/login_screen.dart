import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/components/google_login.dart';
import 'package:myapp/const/color.dart';
import 'package:myapp/screens/login%20sigup%20screen/forget_password.dart';
import 'package:myapp/screens/login%20sigup%20screen/signup_screen.dart';
import 'package:myapp/screens/nav%20screens/mainscreen.dart';
import 'package:myapp/sevices/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _isPasswordVisible = false;

  String email = "", password = "";
  // userLogin() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => const MainScreen()));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: Colors.orangeAccent,
  //           content: Text(
  //             "No User Found for that Email",
  //             style: TextStyle(fontSize: 18.0),
  //           )));
  //     } else if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: Colors.orangeAccent,
  //           content: Text(
  //             "Wrong Password Provided by User",
  //             style: TextStyle(fontSize: 18.0),
  //           )));
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // Check if the user is already signed in
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     // If user is already signed in, navigate to the main screen
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => MainScreen()),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            body: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/security.png'),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Username/Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixIcon:
                                Icon(Icons.email, color: Colors.white70),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email or username';
                            }
                            if (!RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
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
                                const Icon(Icons.lock, color: Colors.white70),
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
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.blue.shade300),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: _loading ? null : _submit,
                              child: _loading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Login',
                                      style: TextStyle(color: bg, fontSize: 18),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
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
                          height: 25,
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
                        // GoogleSignInButton(onPressed: () {
                        //   AuthMethods().signInWithGoogle(context);
                        // }),
                        const SizedBox(height: 25),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'New user?',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                ' Sign Up',
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
        ),
      ],
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Login Successfully!!",
                style: TextStyle(fontSize: 18.0),
              ),
              backgroundColor: Color.fromARGB(255, 77, 81, 79),
            ),
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        }
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }

        // if (e.code == 'weak-password') {
        //   errorMessage = 'Make a strong password!';
        // } else if (e.code == 'email-already-in-use') {
        //   errorMessage = 'The account already exists for that email.';
        // } else if (e.code == 'invalid-email') {
        //   errorMessage = 'The email address is invalid';
        // } else if (e.code == 'operation-not-allowed') {
        //   errorMessage = 'Error!';
        // }
        else {
          errorMessage = 'Invalid Credentials!';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: TextStyle(fontSize: 18.0),
            ),
            backgroundColor: const Color.fromARGB(255, 77, 81, 79),
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      }
    }
  }
}
