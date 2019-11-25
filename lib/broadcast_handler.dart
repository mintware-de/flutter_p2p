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

class WiFiDirectBroadcastReceiver {
  static const _channelBase = FlutterP2p.channelBase;

  static EventChannel _stateChangeChannel =
      EventChannel("$_channelBase/bc/state-change");

  static EventChannel _peersChangeChannel =
      EventChannel("$_channelBase/bc/peers-change");

  static EventChannel _connectionChangeChannel =
      EventChannel("$_channelBase/bc/connection-change");

  static EventChannel _thisDeviceChangeChannel =
      EventChannel("$_channelBase/bc/this-device-change");

  static EventChannel _discoveryChangeChannel =
      EventChannel("$_channelBase/bc/discovery-change");

  static Stream<StateChange> _stateChangeStream;
  static Stream<WifiP2pDeviceList> _peersChangeStream;
  static Stream<ConnectionChange> _connectionChangeStream;
  static Stream<WifiP2pDevice> _thisDeviceChangeStream;
  static Stream<DiscoveryStateChange> _discoveryChangeStream;

  Stream<StateChange> get stateChange {
    if (_stateChangeStream == null) {
      _stateChangeStream = _stateChangeChannel
          .receiveBroadcastStream()
          .map<StateChange>((src) => StateChange.fromBuffer(src));
    }

    return _stateChangeStream;
  }

  Stream<WifiP2pDeviceList> get peersChange {
    if (_peersChangeStream == null) {
      _peersChangeStream = _peersChangeChannel
          .receiveBroadcastStream()
          .map<WifiP2pDeviceList>((src) => WifiP2pDeviceList.fromBuffer(src));
    }

    return _peersChangeStream;
  }

  Stream<ConnectionChange> get connectionChange {
    if (_connectionChangeStream == null) {
      _connectionChangeStream = _connectionChangeChannel
          .receiveBroadcastStream()
          .map<ConnectionChange>((src) => ConnectionChange.fromBuffer(src));
    }

    return _connectionChangeStream;
  }

  Stream<WifiP2pDevice> get thisDeviceChange {
    if (_thisDeviceChangeStream == null) {
      _thisDeviceChangeStream = _thisDeviceChangeChannel
          .receiveBroadcastStream()
          .map<WifiP2pDevice>((src) => WifiP2pDevice.fromBuffer(src));
    }

    return _thisDeviceChangeStream;
  }

  Stream<DiscoveryStateChange> get discoveryChange {
    if (_discoveryChangeStream == null) {
      _discoveryChangeStream = _discoveryChangeChannel
          .receiveBroadcastStream()
          .map<DiscoveryStateChange>(
              (src) => DiscoveryStateChange.fromBuffer(src));
    }

    return _discoveryChangeStream;
  }
}
