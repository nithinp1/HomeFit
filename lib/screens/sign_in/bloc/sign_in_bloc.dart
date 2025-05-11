import 'package:bloc/bloc.dart';
import 'package:homefit/core/service/auth_service.dart';
import 'package:homefit/core/service/validation_service.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<OnTextChangeEvent>((event, emit) {
      if (isButtonEnabled != _checkIfSignInButtonEnabled()) {
        isButtonEnabled = _checkIfSignInButtonEnabled();
        emit(SignInButtonEnableChangedState(isEnabled: isButtonEnabled));
      }
    });

    on<SignInTappedEvent>((event, emit) async {
      if (_checkValidatorsOfTextField()) {
        try {
          emit(LoadingState());
          await AuthService.signIn(
            emailController.text,
            passwordController.text,
          );
          emit(NextTabBarPageState());
          print("Go to the next page");
        } catch (e) {
          print('E to tstrng: $e');
          emit(ErrorState(message: e.toString()));
        }
      } else {
        emit(ShowErrorState());
      }
    });

    on<ForgotPasswordTappedEvent>((event, emit) {
      emit(NextForgotPasswordPageState());
    });

    on<SignUpTappedEvent>((event, emit) {
      emit(NextSignUpPageState());
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;

  bool _checkIfSignInButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool _checkValidatorsOfTextField() {
    return ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text);
  }
}
