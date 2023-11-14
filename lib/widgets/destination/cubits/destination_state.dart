part of 'destination_cubit.dart';

class DestinationState {
  Map? destination;

  DestinationState({@required this.destination});
}

Map initialState() {
  return {
    'places': [],
    'drivers': [],
    'driver': {},
    'destinationValue': {},
    'startPoint': null,
    'sendRequest': {},
    'currentService': {},
    'step': 0,
    'loading': false,
    'error': '',
  };
}
