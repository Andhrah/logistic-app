enum UserType {
  customer('customer'),
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

enum AppToastType { success, failed, normal }

enum ValidationState { isEmpty, isValidateSuccess, isValidateFailed }

enum PaymentType { payOnDelivery, card, bankTransfer }

enum UrlLaunchType { call, email, sms, web }

enum RiderProfileOptions {
  Edit,
  Suspend,
  Delete,
  Null,
}

enum OrderHistoryType { all, fulfilled, inTransit, rejected, referred }
