import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/values/enums.dart';

class SocketStateBloc with BaseBloc<NetworkState, String> {
  SocketStateBloc() {
    updateState(NetworkState.connecting);
  }

  NetworkState networkState = NetworkState.connecting;

  updateState(NetworkState state) async {
    setAsLoading();

    networkState = state;
    addToModel(networkState);
  }

  invalidate() {
    invalidateBaseBloc();
  }

  dispose() async {
    disposeBaseBloc();
  }
}

final socketStateBloc = SocketStateBloc();
