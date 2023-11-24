part of 'login_process_cubit.dart';

class LoginProcessState {
  Map? usercontent;
  LoginProcessState({required this.usercontent});
}

Map initialState() {
  return {
<<<<<<< HEAD
    'isDriver': false,
=======
    'role': 'customer',
>>>>>>> origin/Driver
    'code': 0,
    'token': '',
    'Telephone': "",
    'error': "",
    'statusCode': 0,
  };
}
