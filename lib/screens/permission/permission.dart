import 'package:flutter/material.dart';
import 'package:myapp/const/color.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPermissionScreen extends StatefulWidget {
  const MyPermissionScreen({super.key});

  @override
  State<MyPermissionScreen> createState() => _MyPermissionScreenState();
}

class _MyPermissionScreenState extends State<MyPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    var micStatus;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("permissions"),
              backgroundColor: bg,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.mic),
                  ),
                  onTap: () async {
                    PermissionStatus microphoneStatus =
                        await Permission.microphone.request();
                    if (microphoneStatus == PermissionStatus.granted) {}
                    if (microphoneStatus == PermissionStatus.denied) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("This permission is required")));
                    }
                    if (microphoneStatus ==
                        PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    }
                  },
                  title: const Text("Mic permission"),
                  subtitle: Text("Status of permission : $micStatus"),
                ),
              ],
            ))));
  }
}
