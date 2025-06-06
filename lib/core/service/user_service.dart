import 'package:firebase_auth/firebase_auth.dart';
import 'package:homefit/core/extensions/exceptions.dart';
import 'package:homefit/core/service/auth_service.dart';
import 'dart:developer';

class UserService {
  static final FirebaseAuth firebase = FirebaseAuth.instance;

  static Future<bool> editPhoto(String photoUrl) async {
    try {
      await firebase.currentUser?.updatePhotoURL(photoUrl);
      return true;
    } catch (e) {
      log('Error updating photo URL: $e');
      return false;
    }
  }

  static Future<bool> changeUserData({
    required String displayName,
    required String email,
  }) async {
    try {
      await firebase.currentUser?.updateDisplayName(displayName);
      await firebase.currentUser?.verifyBeforeUpdateEmail(email);
      return true;
    } catch (e) {
      log('Error changing user data: $e');
      throw Exception(e);
    }
  }

  static Future<bool> changePassword({required String newPass}) async {
    try {
      await firebase.currentUser?.updatePassword(newPass);
      return true;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await firebase.signOut();
  }
}
