/*
 * This file is part of the flutter_p2p package.
 *
 * Copyright 2019 by Julian Finkler <julian@mintware.de>
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code.
 *
 */

part of 'flutter_p2p.dart';

class SocketMaster {
  static const _channelBase = FlutterP2p.channelBase;

  var _socketReadChannel = EventChannel("$_channelBase/socket/read");
  final MethodChannel _methodChannel;

  Map<int, P2pSocket> sockets = {};

  Stream<SocketMessage> _readStream;

  SocketMaster(this._methodChannel) {
    _readStream = _socketReadChannel.receiveBroadcastStream().map((a) {
      try {
        return SocketMessage.fromBuffer(a);
      } catch (e) {
        print(e);
        throw e;
      }
    });
  }

  P2pSocket registerSocket(int port, bool isHost) {
    if (sockets[port] == null) {
      sockets[port] = P2pSocket(
        port,
        isHost,
        _readStream.where((s) {
          return s.port == port;
        }),
      );
    }

    return sockets[port];
  }

  unregisterServerPort(int port) {
    if (sockets[port] == null) {
      throw Exception("The port $port is not registered.");
    }

    sockets.remove(port);
  }
}
