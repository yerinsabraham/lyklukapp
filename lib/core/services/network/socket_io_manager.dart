import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/network/endpoints.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// final socketIOManager = Provider((ref) {
//   final authState = ref.watch(authStateProvider);
//   if(authState) return SocketIOManager.instance;
// });

class SocketIOManager {
  io.Socket? socket;
  static SocketIOManager? _instance;

  SocketIOManager._internal() {
    socket = io.io(
      Endpoints.apiV1,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({
            "auth": {
              "token": HiveStorage.accessToken,
            }
          })
          .disableAutoConnect()
          .enableReconnection()
          .build(),
    );

    log.d('SocketIOManager initialized');
    socket!.connect();
    initializeSocketListeners();
    log.d('SocketIOManager ${socket!.connected}');
  }

  static SocketIOManager get instance {
    _instance ??= SocketIOManager._internal();
    return _instance!;
  }

  void initializeSocketListeners() {
    socket!.on('connect', (_) {
      log.d('Connected socket');
    });

    socket!.on('disconnect', (_) {
      log.d('Disconnected socket');
    });

    socket!.on('reconnect_attempt', (attempt) {
      log.d('Reconnection  socket attempt: $attempt');
    });

    socket!.on('reconnect_failed', (_) {
      log.d('Reconnection socket failed ');
    });

    socket!.on('reconnect', (_) {
      log.d('Reconnected socket');
    });
  }

  void emitEvent({required String event, required dynamic data}) {
    // check if it connected
    if (!socket!.connected) {
      socket!.connect();
      socket!.emit(event, data);
    } else {
      socket!.emit(event, data);
    }
  }

  void emitEventWithAck({
    required String event,
    required dynamic data,
    required Function(dynamic) callback,
  }) {
    // check if it connected
    if (!socket!.connected) {
      socket!.connect();
      socket!.emitWithAck(event, data, ack: callback);
    } else {
      socket!.emitWithAck(event, data, ack: callback);
    }
  }

  void listenToEvent({
    required String event,
    required Function(dynamic) callback,
  }) {
    if (!socket!.connected) {
      socket!.connect();
      socket!.on(event, callback);
    } else {
      socket!.on(event, callback);
    }
  }

  void disconnect() {
    socket!.disconnect();
  }
}
