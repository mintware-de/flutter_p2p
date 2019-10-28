///
//  Generated code. Do not modify.
//  source: protos/protos.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'protos.pbenum.dart';

export 'protos.pbenum.dart';

class StateChange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('StateChange', createEmptyInstance: create)
        ..aOB(1, 'isEnabled', protoName: 'isEnabled')
        ..hasRequiredFields = false;

  StateChange._() : super();
  factory StateChange() => create();
  factory StateChange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StateChange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  StateChange clone() => StateChange()..mergeFromMessage(this);
  StateChange copyWith(void Function(StateChange) updates) =>
      super.copyWith((message) => updates(message as StateChange));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StateChange create() => StateChange._();
  StateChange createEmptyInstance() => create();
  static $pb.PbList<StateChange> createRepeated() => $pb.PbList<StateChange>();
  @$core.pragma('dart2js:noInline')
  static StateChange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StateChange>(create);
  static StateChange _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set isEnabled($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIsEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsEnabled() => clearField(1);
}

class WifiP2pDevice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('WifiP2pDevice', createEmptyInstance: create)
        ..aOB(1, 'wpsPbcSupported', protoName: 'wpsPbcSupported')
        ..aOB(2, 'wpsKeypadSupported', protoName: 'wpsKeypadSupported')
        ..aOB(3, 'wpsDisplaySupported', protoName: 'wpsDisplaySupported')
        ..aOB(4, 'isServiceDiscoveryCapable',
            protoName: 'isServiceDiscoveryCapable')
        ..aOB(5, 'isGroupOwner', protoName: 'isGroupOwner')
        ..aOS(6, 'deviceName', protoName: 'deviceName')
        ..aOS(7, 'deviceAddress', protoName: 'deviceAddress')
        ..aOS(8, 'primaryDeviceType', protoName: 'primaryDeviceType')
        ..aOS(9, 'secondaryDeviceType', protoName: 'secondaryDeviceType')
        ..e<WifiP2pDevice_Status>(10, 'status', $pb.PbFieldType.OE,
            defaultOrMaker: WifiP2pDevice_Status.CONNECTED,
            valueOf: WifiP2pDevice_Status.valueOf,
            enumValues: WifiP2pDevice_Status.values)
        ..hasRequiredFields = false;

  WifiP2pDevice._() : super();
  factory WifiP2pDevice() => create();
  factory WifiP2pDevice.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WifiP2pDevice.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  WifiP2pDevice clone() => WifiP2pDevice()..mergeFromMessage(this);
  WifiP2pDevice copyWith(void Function(WifiP2pDevice) updates) =>
      super.copyWith((message) => updates(message as WifiP2pDevice));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WifiP2pDevice create() => WifiP2pDevice._();
  WifiP2pDevice createEmptyInstance() => create();
  static $pb.PbList<WifiP2pDevice> createRepeated() =>
      $pb.PbList<WifiP2pDevice>();
  @$core.pragma('dart2js:noInline')
  static WifiP2pDevice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WifiP2pDevice>(create);
  static WifiP2pDevice _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get wpsPbcSupported => $_getBF(0);
  @$pb.TagNumber(1)
  set wpsPbcSupported($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWpsPbcSupported() => $_has(0);
  @$pb.TagNumber(1)
  void clearWpsPbcSupported() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get wpsKeypadSupported => $_getBF(1);
  @$pb.TagNumber(2)
  set wpsKeypadSupported($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWpsKeypadSupported() => $_has(1);
  @$pb.TagNumber(2)
  void clearWpsKeypadSupported() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get wpsDisplaySupported => $_getBF(2);
  @$pb.TagNumber(3)
  set wpsDisplaySupported($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWpsDisplaySupported() => $_has(2);
  @$pb.TagNumber(3)
  void clearWpsDisplaySupported() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isServiceDiscoveryCapable => $_getBF(3);
  @$pb.TagNumber(4)
  set isServiceDiscoveryCapable($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIsServiceDiscoveryCapable() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsServiceDiscoveryCapable() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isGroupOwner => $_getBF(4);
  @$pb.TagNumber(5)
  set isGroupOwner($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsGroupOwner() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsGroupOwner() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get deviceName => $_getSZ(5);
  @$pb.TagNumber(6)
  set deviceName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDeviceName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeviceName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get deviceAddress => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceAddress($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDeviceAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceAddress() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get primaryDeviceType => $_getSZ(7);
  @$pb.TagNumber(8)
  set primaryDeviceType($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasPrimaryDeviceType() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrimaryDeviceType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get secondaryDeviceType => $_getSZ(8);
  @$pb.TagNumber(9)
  set secondaryDeviceType($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasSecondaryDeviceType() => $_has(8);
  @$pb.TagNumber(9)
  void clearSecondaryDeviceType() => clearField(9);

  @$pb.TagNumber(10)
  WifiP2pDevice_Status get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(WifiP2pDevice_Status v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);
}

class WifiP2pDeviceList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('WifiP2pDeviceList', createEmptyInstance: create)
        ..pc<WifiP2pDevice>(1, 'devices', $pb.PbFieldType.PM,
            subBuilder: WifiP2pDevice.create)
        ..hasRequiredFields = false;

  WifiP2pDeviceList._() : super();
  factory WifiP2pDeviceList() => create();
  factory WifiP2pDeviceList.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WifiP2pDeviceList.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  WifiP2pDeviceList clone() => WifiP2pDeviceList()..mergeFromMessage(this);
  WifiP2pDeviceList copyWith(void Function(WifiP2pDeviceList) updates) =>
      super.copyWith((message) => updates(message as WifiP2pDeviceList));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WifiP2pDeviceList create() => WifiP2pDeviceList._();
  WifiP2pDeviceList createEmptyInstance() => create();
  static $pb.PbList<WifiP2pDeviceList> createRepeated() =>
      $pb.PbList<WifiP2pDeviceList>();
  @$core.pragma('dart2js:noInline')
  static WifiP2pDeviceList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WifiP2pDeviceList>(create);
  static WifiP2pDeviceList _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WifiP2pDevice> get devices => $_getList(0);
}

class ConnectionChange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('ConnectionChange', createEmptyInstance: create)
        ..aOM<WifiP2pInfo>(1, 'wifiP2pInfo',
            protoName: 'wifiP2pInfo', subBuilder: WifiP2pInfo.create)
        ..aOM<NetworkInfo>(2, 'networkInfo',
            protoName: 'networkInfo', subBuilder: NetworkInfo.create)
        ..hasRequiredFields = false;

  ConnectionChange._() : super();
  factory ConnectionChange() => create();
  factory ConnectionChange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConnectionChange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ConnectionChange clone() => ConnectionChange()..mergeFromMessage(this);
  ConnectionChange copyWith(void Function(ConnectionChange) updates) =>
      super.copyWith((message) => updates(message as ConnectionChange));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionChange create() => ConnectionChange._();
  ConnectionChange createEmptyInstance() => create();
  static $pb.PbList<ConnectionChange> createRepeated() =>
      $pb.PbList<ConnectionChange>();
  @$core.pragma('dart2js:noInline')
  static ConnectionChange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConnectionChange>(create);
  static ConnectionChange _defaultInstance;

  @$pb.TagNumber(1)
  WifiP2pInfo get wifiP2pInfo => $_getN(0);
  @$pb.TagNumber(1)
  set wifiP2pInfo(WifiP2pInfo v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWifiP2pInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearWifiP2pInfo() => clearField(1);
  @$pb.TagNumber(1)
  WifiP2pInfo ensureWifiP2pInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  NetworkInfo get networkInfo => $_getN(1);
  @$pb.TagNumber(2)
  set networkInfo(NetworkInfo v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNetworkInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetworkInfo() => clearField(2);
  @$pb.TagNumber(2)
  NetworkInfo ensureNetworkInfo() => $_ensure(1);
}

class WifiP2pInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('WifiP2pInfo', createEmptyInstance: create)
        ..aOB(1, 'groupFormed', protoName: 'groupFormed')
        ..aOB(2, 'isGroupOwner', protoName: 'isGroupOwner')
        ..aOS(3, 'groupOwnerAddress', protoName: 'groupOwnerAddress')
        ..hasRequiredFields = false;

  WifiP2pInfo._() : super();
  factory WifiP2pInfo() => create();
  factory WifiP2pInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WifiP2pInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  WifiP2pInfo clone() => WifiP2pInfo()..mergeFromMessage(this);
  WifiP2pInfo copyWith(void Function(WifiP2pInfo) updates) =>
      super.copyWith((message) => updates(message as WifiP2pInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WifiP2pInfo create() => WifiP2pInfo._();
  WifiP2pInfo createEmptyInstance() => create();
  static $pb.PbList<WifiP2pInfo> createRepeated() => $pb.PbList<WifiP2pInfo>();
  @$core.pragma('dart2js:noInline')
  static WifiP2pInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WifiP2pInfo>(create);
  static WifiP2pInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get groupFormed => $_getBF(0);
  @$pb.TagNumber(1)
  set groupFormed($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasGroupFormed() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupFormed() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isGroupOwner => $_getBF(1);
  @$pb.TagNumber(2)
  set isGroupOwner($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIsGroupOwner() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsGroupOwner() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupOwnerAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupOwnerAddress($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasGroupOwnerAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupOwnerAddress() => clearField(3);
}

class NetworkInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('NetworkInfo', createEmptyInstance: create)
        ..a<$core.int>(1, 'subType', $pb.PbFieldType.O3, protoName: 'subType')
        ..aOB(2, 'isConnected', protoName: 'isConnected')
        ..e<NetworkInfo_DetailedState>(3, 'detailedState', $pb.PbFieldType.OE,
            protoName: 'detailedState',
            defaultOrMaker: NetworkInfo_DetailedState.IDLE,
            valueOf: NetworkInfo_DetailedState.valueOf,
            enumValues: NetworkInfo_DetailedState.values)
        ..aOS(4, 'extraInfo', protoName: 'extraInfo')
        ..hasRequiredFields = false;

  NetworkInfo._() : super();
  factory NetworkInfo() => create();
  factory NetworkInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NetworkInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  NetworkInfo clone() => NetworkInfo()..mergeFromMessage(this);
  NetworkInfo copyWith(void Function(NetworkInfo) updates) =>
      super.copyWith((message) => updates(message as NetworkInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NetworkInfo create() => NetworkInfo._();
  NetworkInfo createEmptyInstance() => create();
  static $pb.PbList<NetworkInfo> createRepeated() => $pb.PbList<NetworkInfo>();
  @$core.pragma('dart2js:noInline')
  static NetworkInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NetworkInfo>(create);
  static NetworkInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get subType => $_getIZ(0);
  @$pb.TagNumber(1)
  set subType($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSubType() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubType() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isConnected => $_getBF(1);
  @$pb.TagNumber(2)
  set isConnected($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIsConnected() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsConnected() => clearField(2);

  @$pb.TagNumber(3)
  NetworkInfo_DetailedState get detailedState => $_getN(2);
  @$pb.TagNumber(3)
  set detailedState(NetworkInfo_DetailedState v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDetailedState() => $_has(2);
  @$pb.TagNumber(3)
  void clearDetailedState() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get extraInfo => $_getSZ(3);
  @$pb.TagNumber(4)
  set extraInfo($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasExtraInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearExtraInfo() => clearField(4);
}

class RequestPermissionResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('RequestPermissionResult', createEmptyInstance: create)
        ..a<$core.int>(1, 'requestCode', $pb.PbFieldType.O3,
            protoName: 'requestCode')
        ..pPS(2, 'grantedPermissions', protoName: 'grantedPermissions')
        ..hasRequiredFields = false;

  RequestPermissionResult._() : super();
  factory RequestPermissionResult() => create();
  factory RequestPermissionResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RequestPermissionResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  RequestPermissionResult clone() =>
      RequestPermissionResult()..mergeFromMessage(this);
  RequestPermissionResult copyWith(
          void Function(RequestPermissionResult) updates) =>
      super.copyWith((message) => updates(message as RequestPermissionResult));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestPermissionResult create() => RequestPermissionResult._();
  RequestPermissionResult createEmptyInstance() => create();
  static $pb.PbList<RequestPermissionResult> createRepeated() =>
      $pb.PbList<RequestPermissionResult>();
  @$core.pragma('dart2js:noInline')
  static RequestPermissionResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPermissionResult>(create);
  static RequestPermissionResult _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get requestCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set requestCode($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequestCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get grantedPermissions => $_getList(1);
}

class SocketMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('SocketMessage', createEmptyInstance: create)
        ..a<$core.int>(1, 'port', $pb.PbFieldType.O3)
        ..a<$core.int>(2, 'dataAvailable', $pb.PbFieldType.O3,
            protoName: 'dataAvailable')
        ..a<$core.List<$core.int>>(3, 'data', $pb.PbFieldType.OY)
        ..hasRequiredFields = false;

  SocketMessage._() : super();
  factory SocketMessage() => create();
  factory SocketMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SocketMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  SocketMessage clone() => SocketMessage()..mergeFromMessage(this);
  SocketMessage copyWith(void Function(SocketMessage) updates) =>
      super.copyWith((message) => updates(message as SocketMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SocketMessage create() => SocketMessage._();
  SocketMessage createEmptyInstance() => create();
  static $pb.PbList<SocketMessage> createRepeated() =>
      $pb.PbList<SocketMessage>();
  @$core.pragma('dart2js:noInline')
  static SocketMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SocketMessage>(create);
  static SocketMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get port => $_getIZ(0);
  @$pb.TagNumber(1)
  set port($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPort() => $_has(0);
  @$pb.TagNumber(1)
  void clearPort() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get dataAvailable => $_getIZ(1);
  @$pb.TagNumber(2)
  set dataAvailable($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDataAvailable() => $_has(1);
  @$pb.TagNumber(2)
  void clearDataAvailable() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}
