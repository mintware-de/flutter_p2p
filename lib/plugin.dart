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

class FlutterP2p {
  static const channelBase = "de.mintware.flutter_p2p";

  static const _channel = const MethodChannel('$channelBase/flutter_p2p');

  static WiFiDirectBroadcastReceiver wifiEvents = WiFiDirectBroadcastReceiver();
  static SocketMaster _socketMaster = SocketMaster(_channel);

  //region Permissions

  static Future<bool> isLocationPermissionGranted() async {
    return await _channel.invokeMethod("isLocationPermissionGranted", {});
  }

  static Future<bool> requestLocationPermission() async {
    return await _channel.invokeMethod("requestLocationPermission", {});
  }

  //endregion

  //region WiFi Event Subscription

  static Future<bool> register() async {
    return await _channel.invokeMethod("register", {});
  }

  static Future<bool> unregister() async {
    return await _channel.invokeMethod("unregister", {});
  }

  //endregion

  //region Discover

  static Future<bool> discoverDevices() async {
    return await _channel.invokeMethod("discover", {});
  }

  static Future<bool> stopDiscoverDevices() async {
    return await _channel.invokeMethod("stopDiscover", {});
  }

  //endregion

  //region Connection

  static Future<bool> connect(WifiP2pDevice device) async {
    return await _channel
        .invokeMethod("connect", {"payload": device.writeToBuffer()});
  }

  static Future<bool> cancelConnect(WifiP2pDevice device) async {
    return await _channel.invokeMethod("cancelConnect", {});
  }

  //endregion

  //region Host Advertising

  static Future<P2pSocket> openHostPort(int port) async {
    await _channel.invokeMethod("openHostPort", {"port": port});
    return _socketMaster.registerSocket(port, true);
  }

  static Future<P2pSocket> closeHostPort(int port) async {
    await _channel.invokeMethod("closeHostPort", {"port": port});
    return _socketMaster.unregisterServerPort(port);
  }

  static Future<bool> acceptPort(int port) async {
    return await _channel.invokeMethod("acceptPort", {"port": port});
  }

  //endregion

  //region Client Connection

  static Future<P2pSocket> connectToHost(
    String address,
    int port, {
    int timeout = 500,
  }) async {
    if (await _channel.invokeMethod("connectToHost", {
      "address": address,
      "port": port,
      "timeout": timeout,
    })) {
      return _socketMaster.registerSocket(port, false);
    }
    return null;
  }

  static Future<bool> disconnectFromHost(int port) async {
    return await _channel.invokeMethod("disconnectFromHost", {
      "port": port,
    });
  }

  //endregion

  //region Data Transfer

  static Future<bool> sendData(int port, bool isHost, Uint8List data) async {
    var req = SocketMessage.create();
    req.port = port;
    req.data = data;
    req.dataAvailable = 0;

    var action = isHost ? "sendDataToClient" : "sendDataToHost";
    return await _channel.invokeMethod(action, {
      "payload": req.writeToBuffer(),
    });
  }

// endregion

}
