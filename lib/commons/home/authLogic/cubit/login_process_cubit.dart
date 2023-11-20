import 'package:agrobeba/customer-app/screens/home.dart';
import 'package:agrobeba/widgets/welcomewidget.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
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
    if (token == "0") {
      emit(LoginProcessState(usercontent: {
        ...state.usercontent!,
        'code': 500,
        'error': "",
      }));
      return;
    }

    print("check token: $token");

    emit(LoginProcessState(usercontent: {
      ...state.usercontent!,
      "code": 200,
      "token": token,
      "phoneNumber": phoneNumber,
    }));

    // Get.to(const HomeScreen());
  }

  void onLogout() async {
    await logout();
    emit(LoginProcessState(usercontent: initialState()));
    Get.offAll(const Welcome());
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
