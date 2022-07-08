enum UserType { user, rider, guest, merchant }

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
