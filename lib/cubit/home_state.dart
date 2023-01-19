// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables, camel_case_types
class HomeStates {}

class HomeInitState extends HomeStates {}

class RegisterLoadingState extends HomeStates {}

class RegisterSuccessState extends HomeStates {}

class RegisterErrorState extends HomeStates {
  final error;

  RegisterErrorState(this.error);
}

class SigninLoadingState extends HomeStates {}

class SigninSuccessState extends HomeStates {
  final String? uid;
  SigninSuccessState({
    this.uid,
  });
}

class SigninErrorState extends HomeStates {
  final error;

  SigninErrorState(this.error);
}

// class getSelectState extends HomeStates {}

// class LogoutSuccessState extends HomeStates {}

// class LogoutErrorState extends HomeStates {}

class CreateUserDataLoadinState extends HomeStates {}

class CreateUserDataSuccessState extends HomeStates {}

class CreateUserDataErrorState extends HomeStates {}

class GetUserDataLoadinState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {}

class ProfileImageLoadingState extends HomeStates {}

class ProfileImageSuccessState extends HomeStates {}

class ProfileImageErrorState extends HomeStates {}

class UploadProfileImageLoadingState extends HomeStates {}

class UploadProfileImageSuccessState extends HomeStates {}

class UploadProfileImageErrorState extends HomeStates {}

class UploadCoverImageLoadingState extends HomeStates {}

class UploadCoverImageSuccessState extends HomeStates {}

class UploadCoverImageErrorState extends HomeStates {}

class CoverImageLoadingState extends HomeStates {}

class CoverImageSuccessState extends HomeStates {}

class CoverImageErrorState extends HomeStates {}

class UpdateUserDataLoadinState extends HomeStates {}

class UpdateUserDataSuccessState extends HomeStates {}

class UpdateUserDataErrorState extends HomeStates {}
class GetHomeDataLoadinState extends HomeStates {}

class GetHomeDataSuccessState extends HomeStates {}

class GetHomeDataErrorState extends HomeStates {}

class IncreasSuccessState extends HomeStates {}

class IncreasErrorState extends HomeStates {}

class RemoveBuySuccessState extends HomeStates {}

class RemoveBuyErrorState extends HomeStates {}

class BorderScreenState extends HomeStates {}
