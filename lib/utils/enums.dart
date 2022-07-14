enum UserType {
  user('user'),
  rider('rider'),
  guest('guest'),
  merchant('merchant'),
  none('none');

  const UserType(this.value);

  final String value;
}

enum RiderOrderState {
  isHomeScreen,
  isNewRequestIncoming,
  isNewRequestClicked,
  isRequestAccepted,
  isAlmostAtPickupLocation,
  isItemPickedUpLocationAndEnRoute,
  isAlmostAtDestinationLocation,
  isAtDestinationLocation,
  isOrderCompleted
}

enum HttpRequestType { get, post, put, patch, delete, head, request, download }

enum AppToastType { success, failed }
