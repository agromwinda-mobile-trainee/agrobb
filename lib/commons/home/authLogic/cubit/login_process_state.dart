part of 'login_process_cubit.dart';

class LoginProcessState {
  Map? usercontent;
  LoginProcessState({required this.usercontent});
}

Map initialState() {
  return {
    'role': 'customer',
    'code': 0,
    'token': '',
    'Telephone': "",
    'error': "",
    'statusCode': 0,
  };
}
