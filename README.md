# flutter_p2p

A Wi-Fi Direct Plugin for Flutter.

This plugin is in alpha and only supports android at the moment.

## Getting Started

### Required permissions
- `android.permission.CHANGE_WIFI_STATE`
- `android.permission.ACCESS_FINE_LOCATION`
- `android.permission.ACCESS_COARSE_LOCATION`
- `android.permission.CHANGE_NETWORK_STATE`
- `android.permission.INTERNET`
- `android.permission.ACCESS_NETWORK_STATE`
- `android.permission.ACCESS_WIFI_STATE`

### Request permission
In order to scan for devices and connect to devices you need to ask for the location Permission
```dart
Future<bool> _checkPermission() async {
  if (!await FlutterP2p.isLocationPermissionGranted()) {
    await FlutterP2p.requestLocationPermission();
    return false;
  }
  return true;
}
```

### Register / unregister from WiFi events
To receive notifications for connection changes or device changes (peers discovered etc.) you have
to subscribe to the wifiEvents and register the plugin to the native events.
```dart
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
    // Stop handling events when the app doesn't run to prevent battery draining
    
    if (state == AppLifecycleState.resumed) {
      _register();
    } else if (state == AppLifecycleState.paused) {
      _unregister();
    }
  }

  List<StreamSubscription> _subscriptions = [];

  void _register() async {
    if (!await _checkPermission()) {
      return;
    }
    _subscriptions.add(FlutterP2p.wifiEvents.stateChange.listen((change) {
      // Handle wifi state change 
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.connectionChange.listen((change) {
      // Handle changes of the connection
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.thisDeviceChange.listen((change) {
      // Handle changes of this device
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.peersChange.listen((change) {
      // Handle discovered peers
    }));

    FlutterP2p.register();  // Register to the native events which are send to the streams above
  }

  void _unregister() {
    _subscriptions.forEach((subscription) => subscription.cancel()); // Cancel subscriptions
    FlutterP2p.unregister(); // Unregister from native events
  }
}
```


### Discover devices
After you subscribed to the events you only need to call the `FlutterP2p.discoverDevices()` method.
```dart

List<WifiP2pDevice> _peers = [];

void _register() async {

  /// ...

  _subscriptions.add(FlutterP2p.wifiEvents.peersChange.listen((change) {
    setState(() {
      _peers = change.devices;
    });
  }));

  /// ...
}

void _discover() {
  FlutterP2p.discoverDevices(); 
}
```

### Connect to a device
Call `FlutterP2p.connect(device);` and listen to the `FlutterP2p.wifiEvents.connectionChange`

```dart

 bool _isConnected = false;
 bool _isHost = false;
 String _deviceAddress = "";

 void _register() async {
    // ...

    _subscriptions.add(FlutterP2p.wifiEvents.connectionChange.listen((change) {
      setState(() {
        _isConnected = change.networkInfo.isConnected;
        _isHost = change.wifiP2pInfo.isGroupOwner;
        _deviceAddress = change.wifiP2pInfo.groupOwnerAddress;
      });
    }));

    // ...
  }
```

### Transferring data between devices
After you are connected to a device you can transfer data async in both directions (client -> host, host -> client).

On the host:
```dart
  // Open a port and create a socket

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
        _showSnackBar("Data Received: $buffer");
        buffer = "";
      }
    });

    // Write data to the client using the _socket.write(UInt8List) or `_socket.writeString("Hello")` method 

    
    print("_openPort done");

    // accept a connection on the created socket
    await FlutterP2p.acceptPort(port);
    print("_accept done");
  }
``` 

On the client:
```dart
  // Connect to the port and create a socket

  P2pSocket _socket;
  _connectToPort(int port) async {
    var socket = await FlutterP2p.connectToHost(
      _deviceAddress, // see above `Connect to a device`
      port,
      timeout: 100000, // timeout in milliseconds (default 500)
    );

    setState(() {
      _socket = socket;
    });

    var buffer = "";
    socket.inputStream.listen((data) {
      var msg = String.fromCharCodes(data.data);
      buffer += msg;

      if (data.dataAvailable == 0) {
        _showSnackBar("Received from host: $buffer");
        buffer = "";
      }
    });
    
    // Write data to the host using the _socket.write(UInt8List) or `_socket.writeString("Hello")` method 

    print("_connectToPort done");
  }
``` 