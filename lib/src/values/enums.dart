/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

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

enum NewOrderState { isNew, isOngoing }

enum NetworkState {
  connecting,
  connected,
  connectionError,
  disconnected,
  noInternet,
  internetTurnedOff
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
  none,
}

enum OrderHistoryType { all, fulfilled, inTransit, rejected, referred }

enum RiderAccountRemovalType { remove, delete, reactivate }

enum OrderStatus { pending, in_transit, completed, declined }

enum RiderOrderStatus {
  pending,
  toPickup,
  toDestination,
  delivered,
  deliveryConfirmed
}
