import 'package:firebase_auth/firebase_auth.dart';
import 'package:homefit/core/const/color_constants.dart';
import 'package:homefit/core/const/data_constants.dart';
import 'package:homefit/core/const/path_constants.dart';
import 'package:homefit/core/const/text_constants.dart';
import 'package:homefit/screens/edit_account/edit_account_screen.dart';
import 'package:homefit/screens/home/bloc/home_bloc.dart';
import 'package:homefit/screens/home/widget/home_statistics.dart';
import 'package:homefit/screens/workout_details_screen/page/workout_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_exercises_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _createProfileData(context),
          const SizedBox(height: 35),
          HomeStatistics(),
          const SizedBox(height: 30),
          _createExercisesList(context),
          const SizedBox(height: 25),
          _createProgress(),
        ],
      ),
    );
  }

  Widget _createExercisesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.discoverWorkouts,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              WorkoutCard(
                color: ColorConstants.cardioColor,
                workout: DataConstants.homeWorkouts[0],
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => WorkoutDetailsPage(
                              workout: DataConstants.workouts[0],
                            ),
                      ),
                    ),
              ),
              const SizedBox(width: 15),
              WorkoutCard(
                color: ColorConstants.armsColor,
                workout: DataConstants.homeWorkouts[1],
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => WorkoutDetailsPage(
                              workout: DataConstants.workouts[2],
                            ),
                      ),
                    ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createProfileData(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "No Username";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $displayName',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                TextConstants.checkActivity,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (_, currState) => currState is ReloadImageState,
            builder: (context, state) {
              final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
              return GestureDetector(
                child:
                    photoUrl == null
                        ? CircleAvatar(
                          backgroundImage: AssetImage(PathConstants.profile),
                          radius: 60,
                        )
                        : CircleAvatar(
                          radius: 25,
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: PathConstants.profile,
                              image: photoUrl,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 120,
                            ),
                          ),
                        ),
                onTap: () async {
                  if (!context.mounted) return;
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EditAccountScreen()),
                  );
                  if (!context.mounted) return;
                  BlocProvider.of<HomeBloc>(context).add(ReloadImageEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createProgress() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(
              ColorConstants.textBlack.r.toInt(),
              ColorConstants.textBlack.g.toInt(),
              ColorConstants.textBlack.b.toInt(),
              0.12,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Row(
        children: [
          Image(image: AssetImage(PathConstants.progress)),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstants.keepProgress,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  TextConstants.profileSuccessful,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
