/*
 * This file is part of the flutter_p2p package.
 *
 * Copyright 2019 by Julian Finkler <julian@mintware.de>
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code.
 *
 */

package de.mintware.flutter_p2p.wifi_direct

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.NetworkInfo
import android.net.wifi.p2p.WifiP2pDevice
import android.net.wifi.p2p.WifiP2pInfo
import android.net.wifi.p2p.WifiP2pManager
import de.mintware.flutter_p2p.Protos
import de.mintware.flutter_p2p.utility.ProtoHelper
import io.flutter.plugin.common.EventChannel

class WiFiDirectBroadcastReceiver(private val manager: WifiP2pManager,
                                  private val channel: WifiP2pManager.Channel,
                                  private val stateChangedSink: EventChannel.EventSink?,
                                  peersChangedSink: EventChannel.EventSink?,
                                  private val connectionChangedSink: EventChannel.EventSink?,
                                  private val thisDeviceChangedSink: EventChannel.EventSink?
) : BroadcastReceiver() {

    private val peerListListener = WiFiDirectPeerListListener(peersChangedSink)

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent == null) {
            return
        }

        when (intent.action) {
            WifiP2pManager.WIFI_P2P_STATE_CHANGED_ACTION -> onStateChanged(intent)
            WifiP2pManager.WIFI_P2P_PEERS_CHANGED_ACTION -> onPeersChanged()
            WifiP2pManager.WIFI_P2P_CONNECTION_CHANGED_ACTION -> onConnectionChanged(intent)
            WifiP2pManager.WIFI_P2P_THIS_DEVICE_CHANGED_ACTION -> onThisDeviceChanged(intent)
        }
    }

    private fun onConnectionChanged(intent: Intent) {
        val p2pInfo = intent.getParcelableExtra(WifiP2pManager.EXTRA_WIFI_P2P_INFO) as WifiP2pInfo
        val networkInfo = intent.getParcelableExtra(WifiP2pManager.EXTRA_NETWORK_INFO) as NetworkInfo

        manager.let { manager ->

            if (networkInfo.isConnected) {

                manager.requestConnectionInfo(channel) { info ->
                    // InetAddress from WifiP2pInfo struct.
                    val groupOwnerAddress: String = info.groupOwnerAddress.hostAddress

                    // After the group negotiation, we can determine the group owner
                    // (server).
                    if (info.groupFormed && info.isGroupOwner) {
                        // Do whatever tasks are specific to the group owner.
                        // One common case is creating a group owner thread and accepting
                        // incoming connections.
                    } else if (info.groupFormed) {
                        // The other device acts as the peer (client). In this case,
                        // you'll want to create a peer thread that connects
                        // to the group owner.
                    }

                }
            }
        }

        connectionChangedSink?.success(ProtoHelper.create(p2pInfo, networkInfo).toByteArray())
    }

    private fun onStateChanged(intent: Intent) {
        val state = intent.getIntExtra(WifiP2pManager.EXTRA_WIFI_STATE, -1)
        val isConnected = state == WifiP2pManager.WIFI_P2P_STATE_ENABLED
        val stateChange: Protos.StateChange = ProtoHelper.create(isConnected)

        stateChangedSink?.success(stateChange.toByteArray())
    }

    private fun onPeersChanged() {
        manager.requestPeers(channel, peerListListener)
    }

    private fun onThisDeviceChanged(intent: Intent) {
        val device = intent.getParcelableExtra(WifiP2pManager.EXTRA_WIFI_P2P_DEVICE) as WifiP2pDevice
        val dev: Protos.WifiP2pDevice = ProtoHelper.create(device)
        thisDeviceChangedSink?.success(dev.toByteArray())
    }
}