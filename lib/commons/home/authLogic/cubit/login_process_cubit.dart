import 'package:agrobeba/customer-app/screens/home.dart';
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
    }));

    // Get.to(const HomeScreen());
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
