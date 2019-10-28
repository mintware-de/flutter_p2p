///
//  Generated code. Do not modify.
//  source: protos/protos.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const StateChange$json = const {
  '1': 'StateChange',
  '2': const [
    const {'1': 'isEnabled', '3': 1, '4': 1, '5': 8, '10': 'isEnabled'},
  ],
};

const WifiP2pDevice$json = const {
  '1': 'WifiP2pDevice',
  '2': const [
    const {
      '1': 'wpsPbcSupported',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'wpsPbcSupported'
    },
    const {
      '1': 'wpsKeypadSupported',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'wpsKeypadSupported'
    },
    const {
      '1': 'wpsDisplaySupported',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'wpsDisplaySupported'
    },
    const {
      '1': 'isServiceDiscoveryCapable',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'isServiceDiscoveryCapable'
    },
    const {'1': 'isGroupOwner', '3': 5, '4': 1, '5': 8, '10': 'isGroupOwner'},
    const {'1': 'deviceName', '3': 6, '4': 1, '5': 9, '10': 'deviceName'},
    const {'1': 'deviceAddress', '3': 7, '4': 1, '5': 9, '10': 'deviceAddress'},
    const {
      '1': 'primaryDeviceType',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'primaryDeviceType'
    },
    const {
      '1': 'secondaryDeviceType',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'secondaryDeviceType'
    },
    const {
      '1': 'status',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.WifiP2pDevice.Status',
      '10': 'status'
    },
  ],
  '4': const [WifiP2pDevice_Status$json],
};

const WifiP2pDevice_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'CONNECTED', '2': 0},
    const {'1': 'INVITED', '2': 1},
    const {'1': 'FAILED', '2': 2},
    const {'1': 'AVAILABLE', '2': 3},
    const {'1': 'UNAVAILABLE', '2': 4},
  ],
};

const WifiP2pDeviceList$json = const {
  '1': 'WifiP2pDeviceList',
  '2': const [
    const {
      '1': 'devices',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.WifiP2pDevice',
      '10': 'devices'
    },
  ],
};

const ConnectionChange$json = const {
  '1': 'ConnectionChange',
  '2': const [
    const {
      '1': 'wifiP2pInfo',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.WifiP2pInfo',
      '10': 'wifiP2pInfo'
    },
    const {
      '1': 'networkInfo',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.NetworkInfo',
      '10': 'networkInfo'
    },
  ],
};

const WifiP2pInfo$json = const {
  '1': 'WifiP2pInfo',
  '2': const [
    const {'1': 'groupFormed', '3': 1, '4': 1, '5': 8, '10': 'groupFormed'},
    const {'1': 'isGroupOwner', '3': 2, '4': 1, '5': 8, '10': 'isGroupOwner'},
    const {
      '1': 'groupOwnerAddress',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'groupOwnerAddress'
    },
  ],
};

const NetworkInfo$json = const {
  '1': 'NetworkInfo',
  '2': const [
    const {'1': 'subType', '3': 1, '4': 1, '5': 5, '10': 'subType'},
    const {'1': 'isConnected', '3': 2, '4': 1, '5': 8, '10': 'isConnected'},
    const {
      '1': 'detailedState',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.NetworkInfo.DetailedState',
      '10': 'detailedState'
    },
    const {'1': 'extraInfo', '3': 4, '4': 1, '5': 9, '10': 'extraInfo'},
  ],
  '4': const [NetworkInfo_DetailedState$json],
};

const NetworkInfo_DetailedState$json = const {
  '1': 'DetailedState',
  '2': const [
    const {'1': 'IDLE', '2': 0},
    const {'1': 'SCANNING', '2': 1},
    const {'1': 'CONNECTING', '2': 2},
    const {'1': 'AUTHENTICATING', '2': 3},
    const {'1': 'OBTAINING_IPADDR', '2': 4},
    const {'1': 'CONNECTED', '2': 5},
    const {'1': 'SUSPENDED', '2': 6},
    const {'1': 'DISCONNECTING', '2': 7},
    const {'1': 'DISCONNECTED', '2': 8},
    const {'1': 'FAILED', '2': 9},
    const {'1': 'BLOCKED', '2': 10},
    const {'1': 'VERIFYING_POOR_LINK', '2': 11},
    const {'1': 'CAPTIVE_PORTAL_CHECK', '2': 12},
  ],
};

const RequestPermissionResult$json = const {
  '1': 'RequestPermissionResult',
  '2': const [
    const {'1': 'requestCode', '3': 1, '4': 1, '5': 5, '10': 'requestCode'},
    const {
      '1': 'grantedPermissions',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'grantedPermissions'
    },
  ],
};

const SocketMessage$json = const {
  '1': 'SocketMessage',
  '2': const [
    const {'1': 'port', '3': 1, '4': 1, '5': 5, '10': 'port'},
    const {'1': 'dataAvailable', '3': 2, '4': 1, '5': 5, '10': 'dataAvailable'},
    const {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};
