import 'package:flutter/material.dart';
import 'package:myapp/const/color.dart';
import 'package:myapp/screens/nav%20screens/profile/edit_profile_screen.dart';
import 'package:myapp/screens/nav%20screens/profile/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends StatelessWidget {
  // final UserProfile userProfile;

  // MyProfileScreen({required this.userProfile});

  void selectImage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Abril Fatface',
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          String email = snapshot.data?.getString('email') ?? '';
          String username = snapshot.data?.getString('name') ?? '';

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngwing.com%2Fen%2Fsearch%3Fq%3Ddefault%2BAvatar&psig=AOvVaw3SprLNZayjPm1RCfJVW511&ust=1716149960394000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNCxxfyCmIYDFQAAAAAdAAAAABAE'),
                          ),
                          Positioned(
                            child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(Icons.add_a_photo)),
                            bottom: -10,
                            left: 80,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        username,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        email,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => EditProfileScreen(
                          //           userProfile: userProfile)),
                          // );
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
