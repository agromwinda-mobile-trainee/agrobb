import 'dart:developer';
import 'package:agrobeba/commons/home/welcomewidget.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import '../../api_contents/functions/getfunctions.dart';
part 'login_process_state.dart';

class LoginProcessCubit extends Cubit<LoginProcessState> {
  LoginProcessCubit() : super(LoginProcessState(usercontent: initialState()));

  void onChangeusercontent({required String field, required value}) async {
    emit(LoginProcessState(usercontent: {
      ...state.usercontent!,
      field: value,
    }));
  }

  void checkUser() async {
    final String? token = await getToken();
    final String? phoneNumber = await getPhoneNumber();
    if (token == null) {
      emit(LoginProcessState(usercontent: {
        ...state.usercontent!,
        'code': 500,
        'error': "",
      }));
      print("token not found");
      return;
    } else {
      print("check token: $token");

      emit(LoginProcessState(usercontent: {
        ...state.usercontent!,
        "code": 200,
        "token": token,
        "phoneNumber": phoneNumber,
      }));
    }

    // Get.to(const HomeScreen());
  }

  void onLogout() async {
    try {
      await logout();
      emit(LoginProcessState(usercontent: initialState()));
      Get.offAll(const Welcome());
    } catch (error) {
      log(error.toString());
    }
  }
}

//model auth

Map AuthModel() {
  return {
    'Telephone': "",
    'error': "",
    'statusCode': 0,
  };
}
