import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xffEFDA30),
      animation: const AlwaysStoppedAnimation<double>(1),
      content: SlideInUp(
        duration: const Duration(milliseconds: 500),
        delay: const Duration(milliseconds: 500),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 28),
            const FaIcon(FontAwesomeIcons.triangleExclamation,
                color: Color(0xff00003D)),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                message,
                //textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xff00003D),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
