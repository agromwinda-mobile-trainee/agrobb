part of 'driver_cubit.dart';

class DriverState {
  Map? driver;

  DriverState({@required this.driver});
}

Map initialState() {
  return {
    'currentPosition': {},
    'commandes': [],
    'acceptedCommande': null,
    'checkDriverAvailability': false,
  };
}
