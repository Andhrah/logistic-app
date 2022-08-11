import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/values/enums.dart';

class RiderHomeStateBloc with BaseBloc<RiderOrderState, String> {
  RiderHomeStateBloc() {
    updateState(RiderOrderState.isHomeScreen);
  }

  RiderOrderState riderOrderState = RiderOrderState.isHomeScreen;

  updateState(RiderOrderState _riderOrderState) async {
    setAsLoading();

    if (_riderOrderState == RiderOrderState.isNewRequestIncoming) {
      riderOrderStateBloc.updateState(NewOrderState.isOngoing);
    } else if ((_riderOrderState == RiderOrderState.isHomeScreen) ||
        (_riderOrderState == RiderOrderState.isOrderCompleted)) {
      riderOrderStateBloc.updateState(NewOrderState.isNew);
    }

    riderOrderState = _riderOrderState;
    addToModel(riderOrderState);
  }

  invalidate() {
    invalidateBaseBloc();
  }

  dispose() async {
    disposeBaseBloc();
  }
}

final riderHomeStateBloc = RiderHomeStateBloc();

class RiderOrderStateBloc with BaseBloc<NewOrderState, String> {
  RiderOrderStateBloc() {
    updateState(NewOrderState.isNew);
  }

  NewOrderState newOrderState = NewOrderState.isNew;

  updateState(NewOrderState state) async {
    setAsLoading();

    newOrderState = state;
    addToModel(newOrderState);
  }

  invalidate() {
    invalidateBaseBloc();
  }

  dispose() async {
    disposeBaseBloc();
  }
}

final riderOrderStateBloc = RiderOrderStateBloc();
