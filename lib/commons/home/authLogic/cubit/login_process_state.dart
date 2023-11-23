part of 'login_process_cubit.dart';

@immutable
class LoginProcessState {
  Map? usercontent;
  LoginProcessState({required this.usercontent});
}

Map initialState() {
  return {
    'Usertoken': [],
  };
}
