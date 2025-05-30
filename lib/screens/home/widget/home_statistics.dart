import 'package:homefit/core/const/color_constants.dart';
import 'package:homefit/core/const/path_constants.dart';
import 'package:homefit/core/const/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:homefit/core/const/data_constants.dart';

class HomeStatistics extends StatelessWidget {
  const HomeStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_createComletedWorkouts(context), _createColumnStatistics()],
      ),
    );
  }

  Widget _createComletedWorkouts(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate completed workouts dynamically
    final completedWorkouts =
        DataConstants.workouts
            .where((workout) => workout.currentProgress == workout.progress)
            .length;

    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * 0.35,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Image(image: AssetImage(PathConstants.finished)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  TextConstants.finished,
                  style: TextStyle(
                    color: ColorConstants.textBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ],
          ),
          Text(
            completedWorkouts.toString(),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textBlack,
            ),
          ),
          Text(
            TextConstants.completedWorkouts,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createColumnStatistics() {
    return Column(
      children: [
        DataWorkouts(
          icon: PathConstants.inProgress,
          title: TextConstants.inProgress,
          count: 2,
          text: TextConstants.workouts,
        ),
        const SizedBox(height: 20),
        DataWorkouts(
          icon: PathConstants.timeSent,
          title: TextConstants.timeSent,
          count: 62,
          text: TextConstants.minutes,
        ),
      ],
    );
  }
}

class DataWorkouts extends StatelessWidget {
  final String icon;
  final String title;
  final int count;
  final String text;

  const DataWorkouts({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 90,
      width: screenWidth * 0.5,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Image(image: AssetImage(icon)),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textBlack,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textBlack,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
