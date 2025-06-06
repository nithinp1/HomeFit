import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:homefit/core/const/color_constants.dart';
import 'package:homefit/core/const/path_constants.dart';
import 'package:homefit/core/const/text_constants.dart';
import 'package:homefit/core/service/auth_service.dart';
import 'package:homefit/screens/common_widgets/settings_container.dart';
import 'package:homefit/screens/edit_account/edit_account_screen.dart';
import 'package:homefit/screens/reminder/page/reminder_page.dart';
import 'package:homefit/screens/settings/bloc/bloc/settings_bloc.dart';
import 'package:homefit/screens/sign_in/page/sign_in_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:homefit/core/const/data_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String? photoUrl;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContext(context));
  }

  BlocProvider<SettingsBloc> _buildContext(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (_, currState) => currState is SettingsInitial,
        builder: (context, state) {
          return _settingsContent(context);
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

  Widget _settingsContent(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "No Username";
    photoUrl = user?.photoURL;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child:
                        photoUrl == null
                            ? CircleAvatar(
                              backgroundImage: AssetImage(
                                PathConstants.profile,
                              ),
                              radius: 60,
                            )
                            : CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: PathConstants.profile,
                                  image: photoUrl!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 120,
                                ),
                              ),
                            ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                        ColorConstants.primaryColor.r.toInt(),
                        ColorConstants.primaryColor.g.toInt(),
                        ColorConstants.primaryColor.b.toInt(),
                        0.16,
                      ),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.edit, color: ColorConstants.primaryColor),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAccountScreen(),
                        ),
                      );
                      setState(() {
                        photoUrl = user?.photoURL;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                displayName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              SettingsContainer(
                withArrow: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ReminderPage()),
                  );
                },
                child: Text(
                  TextConstants.reminder,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              if (!kIsWeb)
                SettingsContainer(
                  child: Text(
                    TextConstants.rateUsOn +
                        (Platform.isIOS ? 'App store' : 'Play market'),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    return _launchUrl(
                      Platform.isIOS
                          ? 'https://www.apple.com/app-store/'
                          : 'https://play.google.com/store',
                    );
                  },
                ),
              SettingsContainer(
                onTap: () => _launchUrl('https://perpet.io/'),
                child: Text(
                  TextConstants.terms,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              SettingsContainer(
                child: Text(
                  TextConstants.signOut,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  AuthService.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SignInPage()),
                  );
                },
              ),
              SettingsContainer(
                child: Text(
                  'Reset Workouts',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  setState(() {
                    for (var workout in DataConstants.workouts) {
                      workout.currentProgress = 0;
                      workout.progress = 0;
                      for (var exercise in workout.exerciseDataList) {
                        exercise.progress = 0;
                      }
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Workouts have been reset!')),
                  );
                },
              ),
              SizedBox(height: 15),
              Text(
                TextConstants.joinUs,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed:
                        () => _launchUrl('https://www.facebook.com/perpetio/'),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 1,
                    ),
                    child: Image.asset(PathConstants.facebook),
                  ),
                  TextButton(
                    onPressed:
                        () => _launchUrl('https://www.instagram.com/perpetio/'),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 1,
                    ),
                    child: Image.asset(PathConstants.instagram),
                  ),
                  TextButton(
                    onPressed: () => _launchUrl('https://twitter.com/perpetio'),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 1,
                    ),
                    child: Image.asset(PathConstants.twitter),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
