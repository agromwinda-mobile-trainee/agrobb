part of 'destination_cubit.dart';

class DestinationState {
  Map? destination;

  DestinationState({@required this.destination});
}

Map initialState() {
  return {
    'gettingPlaces': false,
    'places': [],
    'drivers': [],
    'driver': {},
    'emplacementForm': {
      "destinationValue": "",
      "startPoint": "",
    },
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/cubits/destination_state.dart
    'selectedServiceID': 0,
=======
>>>>>>> origin/Driver:lib/widgets/destination/cubits/destination_state.dart
    'destinationValue': null,
    'startPoint': null,
    'emplacementField': '',
    'sendRequest': {},
    'currentService': {},
    'step': 0,
    'loading': false,
    'error': '',
  };
}
