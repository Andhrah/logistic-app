enum UserType {
  user('user'),
  rider('rider'),
  guest('guest'),
  merchant('merchant');

const UserType(this.value);

  final String value;

}


enum RiderOrderState {
  isHomeScreen,
  isNewRequest,
  isRequestAccepted,
  isAlmostAtPickupLocation,
  isItemPickedUpLocation,
  isEnRoute,
  isAlmostAtDestinationLocation,
  isAtDestinationLocation,
  isOrderCompleted
}

enum HttpRequestType { get, post, put, patch, delete, head, request, download }
