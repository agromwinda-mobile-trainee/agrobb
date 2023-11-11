import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api_contents/functions/getfunctions.dart';

part 'login_process_state.dart';

class LoginProcessCubit extends Cubit<LoginProcessState> {
  LoginProcessCubit() : super(LoginProcessState(usercontent: AuthModel()));

  void onChangeusercontent({required String field, required value}) async {
    emit(LoginProcessState(usercontent: {
      ...state.usercontent!,
      field: value,
    }));
  }

  void checkUser() async {
    final Map? userAuth = await getToken();
    if (userAuth!['code'] == 500) {
      emit(LoginProcessState(usercontent: {
        'statusCode': 500,
        'error': userAuth['message'],
      }));
      return;
    }

    if (userAuth['code'] == 404) {
      emit(LoginProcessState(usercontent: {
        'statusCode': 404,
        'error': userAuth['message'],
      }));
      return;
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
