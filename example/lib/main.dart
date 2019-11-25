/*
 * This file is part of the flutter_p2p package.
 *
 * Copyright 2019 by Julian Finkler <julian@mintware.de>
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code.
 *
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_p2p/flutter_p2p.dart';
import 'package:flutter_p2p/gen/protos/protos.pb.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _register();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _register();
    } else if (state == AppLifecycleState.paused) {
      _unregister();
    }
  }

  List<WifiP2pDevice> devices = [];

  var _isConnected = false;
  var _isHost = false;

  List<StreamSubscription> _subscriptions = [];

  void _register() async {
    if (!await _checkPermission()) {
      return;
    }
    _subscriptions.add(FlutterP2p.wifiEvents.stateChange.listen((change) {
      print("stateChange: ${change.isEnabled}");
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.connectionChange.listen((change) {
      setState(() {
        _isConnected = change.networkInfo.isConnected;
        _isHost = change.wifiP2pInfo.isGroupOwner;
        _deviceAddress = change.wifiP2pInfo.groupOwnerAddress;
      });
      print(
          "connectionChange: ${change.wifiP2pInfo.isGroupOwner}, Connected: ${change.networkInfo.isConnected}");
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.thisDeviceChange.listen((change) {
      print(
          "deviceChange: ${change.deviceName} / ${change.deviceAddress} / ${change.primaryDeviceType} / ${change.secondaryDeviceType} ${change.isGroupOwner ? 'GO' : '-GO'}");
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.discoveryChange.listen((change) {
      print("discoveryStateChange: ${change.isDiscovering}");
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.peersChange.listen((change) {
      print("peersChange: ${change.devices.length}");
      change.devices.forEach((device) {
        print("device: ${device.deviceName} / ${device.deviceAddress}");
      });

      setState(() {
        devices = change.devices;
      });
    }));

    FlutterP2p.register();
  }

  void _unregister() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    FlutterP2p.unregister();
  }

  P2pSocket _socket;
  void _openPortAndAccept(int port) async {
    var socket = await FlutterP2p.openHostPort(port);
    setState(() {
      _socket = socket;
    });

    var buffer = "";
    socket.inputStream.listen((data) {
      var msg = String.fromCharCodes(data.data);
      buffer += msg;
      if (data.dataAvailable == 0) {
        snackBar("Data Received: $buffer");
        socket.writeString("Successfully received: $buffer");
        buffer = "";
      }
    });

    print("_openPort done");

    await FlutterP2p.acceptPort(port);
    print("_accept done");
  }

  var _deviceAddress = "";

  _connectToPort(int port) async {
    var socket = await FlutterP2p.connectToHost(
      _deviceAddress,
      port,
      timeout: 100000,
    );

    setState(() {
      _socket = socket;
    });

    _socket.inputStream.listen((data) {
      var msg = utf8.decode(data.data);
      snackBar("Received from Host: $msg");
    });

    print("_connectToPort done");
  }

  Future<bool> _checkPermission() async {
    if (!await FlutterP2p.isLocationPermissionGranted()) {
      await FlutterP2p.requestLocationPermission();
      return false;
    }
    return true;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Plugin example app 2'),
        ),
        body: Column(
          children: <Widget>[
            Text(_isConnected
                ? "Connected: ${_isHost ? "Host" : "Client"}"
                : "Disconnected"),
            RaisedButton(
              onPressed: () => FlutterP2p.discoverDevices(),
              child: Text("Discover Devices"),
            ),
            RaisedButton(
              onPressed: _isConnected && _isHost
                  ? () => _openPortAndAccept(8888)
                  : null,
              child: Text("Open and accept data from port 8888"),
            ),
            RaisedButton(
              onPressed: _isConnected ? () => _connectToPort(8888) : null,
              child: Text("Connect to port 8888"),
            ),
            RaisedButton(
              onPressed: _socket != null
                  ? () => _socket.writeString("Hello World")
                  : null,
              child: Text("Send hello world"),
            ),
            Expanded(
              child: ListView(
                children: this.devices.map((d) {
                  return ListTile(
                    title: Text(d.deviceName),
                    subtitle: Text(d.deviceAddress),
                    onTap: () {
                      print(
                          "${_isConnected ? "Disconnect" : "Connect"} to device: $_deviceAddress");
                      return _isConnected
                          ? FlutterP2p.cancelConnect(d)
                          : FlutterP2p.connect(d);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  snackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
