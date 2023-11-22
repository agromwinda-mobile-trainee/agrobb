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
