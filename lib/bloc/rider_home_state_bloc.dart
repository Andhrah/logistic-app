import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/utils/enums.dart';

class RiderHomeStateBloc with BaseBloc<RiderOrderState, String> {
  RiderHomeStateBloc() {
    updateState(RiderOrderState.isHomeScreen);
  }

  RiderOrderState riderOrderState = RiderOrderState.isHomeScreen;

  updateState(RiderOrderState _riderOrderState) async {
    setAsLoading();

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
