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

import android.net.wifi.p2p.WifiP2pDevice
import android.net.wifi.p2p.WifiP2pDeviceList
import android.net.wifi.p2p.WifiP2pManager
import android.util.Log
import de.mintware.flutter_p2p.utility.ProtoHelper
import io.flutter.plugin.common.EventChannel

class WiFiDirectPeerListListener(private val peersChangedSink: EventChannel.EventSink?
) : WifiP2pManager.PeerListListener {
    companion object {
        const val TAG = "Flutter P2P"
    }

    private val peers = mutableListOf<WifiP2pDevice>()

    override fun onPeersAvailable(peerList: WifiP2pDeviceList) {
        val refreshedPeers = peerList.deviceList
        if ( refreshedPeers != peers) {
            peers.clear()

            if (refreshedPeers != null) {
                peers.addAll(refreshedPeers)
            }

            peersChangedSink?.success(ProtoHelper.create(peers).toByteArray())
        }

        if (peers.isEmpty()) {
            Log.d(TAG, "No devices found")
            return
        }
    }

}