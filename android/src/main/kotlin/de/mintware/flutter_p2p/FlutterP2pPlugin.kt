/*
 * This file is part of the flutter_p2p package.
 *
 * Copyright 2019 by Julian Finkler <julian@mintware.de>
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code.
 *
 */

package de.mintware.flutter_p2p

import android.Manifest
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.ContentValues.TAG
import android.content.Context
import android.content.IntentFilter
import android.net.wifi.p2p.WifiP2pManager
import android.os.Looper
import android.util.Log
import java.lang.reflect.Method
import java.util.HashMap
import android.content.pm.PackageManager
import android.net.wifi.p2p.WifiP2pConfig
import de.mintware.flutter_p2p.utility.EventChannelPool
import de.mintware.flutter_p2p.wifi_direct.SocketPool
import de.mintware.flutter_p2p.wifi_direct.WiFiDirectBroadcastReceiver


class FlutterP2pPlugin(private val registrar: Registrar
) : MethodCallHandler {

    private val intentFilter = IntentFilter()
    private var receiver: WiFiDirectBroadcastReceiver? = null
    private val eventPool: EventChannelPool = EventChannelPool(registrar.messenger())
    private lateinit var socketPool: SocketPool

    private lateinit var channel: WifiP2pManager.Channel
    private lateinit var manager: WifiP2pManager

    companion object {
        private const val REQUEST_ENABLE_LOCATION = 600
        private const val CH_STATE_CHANGE = "bc/state-change"
        private const val CH_PEERS_CHANGE = "bc/peers-change"
        private const val CH_CON_CHANGE = "bc/connection-change"
        private const val CH_DEVICE_CHANGE = "bc/this-device-change"
        private const val CH_SOCKET_READ = "socket/read"
        val config: Config = Config();

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "de.mintware.flutter_p2p/flutter_p2p")

            val plugin = FlutterP2pPlugin(registrar)
            plugin.setupEventPool()
            channel.setMethodCallHandler(plugin)
        }
    }

    init {
        setupIntentFilters()
        setupWifiP2pManager()
    }

    fun setupEventPool() {
        eventPool.register(CH_STATE_CHANGE)
        eventPool.register(CH_PEERS_CHANGE)
        eventPool.register(CH_CON_CHANGE)
        eventPool.register(CH_DEVICE_CHANGE)
        eventPool.register(CH_SOCKET_READ)

        socketPool = SocketPool(eventPool.getHandler(CH_SOCKET_READ))
    }

    private fun setupIntentFilters() {
        intentFilter.apply {
            // Indicates a change in the Wi-Fi P2P status.
            addAction(WifiP2pManager.WIFI_P2P_STATE_CHANGED_ACTION)
            // Indicates a change in the list of available peers.
            addAction(WifiP2pManager.WIFI_P2P_PEERS_CHANGED_ACTION)
            // Indicates the state of Wi-Fi P2P connectivity has changed.
            addAction(WifiP2pManager.WIFI_P2P_CONNECTION_CHANGED_ACTION)
            // Indicates this device'base details have changed.
            addAction(WifiP2pManager.WIFI_P2P_THIS_DEVICE_CHANGED_ACTION)
        }
    }

    private fun setupWifiP2pManager() {
        manager = registrar.context().getSystemService(Context.WIFI_P2P_SERVICE) as WifiP2pManager
        channel = manager.initialize(registrar.context(), Looper.getMainLooper(), null)
    }


    //region Platform channel methods


    //region Permissions

    @Suppress("unused", "UNUSED_PARAMETER")
    private fun requestLocationPermission(call: MethodCall, result: Result) {
        val perm = arrayOf(Manifest.permission.ACCESS_FINE_LOCATION)
        registrar.activity().requestPermissions(perm, REQUEST_ENABLE_LOCATION)
        result.success(true)
    }

    @Suppress("unused", "UNUSED_PARAMETER")
    private fun isLocationPermissionGranted(call: MethodCall, result: Result) {
        val permission = Manifest.permission.ACCESS_FINE_LOCATION
        result.success(PackageManager.PERMISSION_GRANTED == registrar.context().checkSelfPermission(permission))
    }
    //endregion

    //region WiFi Event Subscription

    /**
     * Subscribe to WiFi Events
     *
     * @param call The Method call
     * @param result The Method result
     */
    @Suppress("unused", "UNUSED_PARAMETER")
    fun register(call: MethodCall, result: Result) {
        if (receiver != null) {
            result.success(false)
            return
        }

        receiver = WiFiDirectBroadcastReceiver(
                manager,
                channel,
                eventPool.getHandler(CH_STATE_CHANGE).sink,
                eventPool.getHandler(CH_PEERS_CHANGE).sink,
                eventPool.getHandler(CH_CON_CHANGE).sink,
                eventPool.getHandler(CH_DEVICE_CHANGE).sink
        )
        registrar.context().registerReceiver(receiver, intentFilter)
        result.success(true)
    }

    /**
     * Unsubscribe from WiFi Events
     *
     * @param call The Method call
     * @param result The Method result
     */
    @Suppress("unused", "UNUSED_PARAMETER")
    fun unregister(call: MethodCall, result: Result) {
        if (receiver == null) {
            result.success(false)
            return
        }

        registrar.context().unregisterReceiver(receiver)
        result.success(true)
    }
    //endregion

    //region Discover

    /**
     * Start discovering WiFi devices
     *
     * @param call The Method call
     * @param result The Method result
     */
    @Suppress("unused", "UNUSED_PARAMETER")
    fun discover(call: MethodCall, result: Result) {
        manager.discoverPeers(channel, object : WifiP2pManager.ActionListener {
            override fun onSuccess() {
                result.success(true)
            }

            override fun onFailure(reasonCode: Int) {
                result.error(reasonCode.toString(), null, null)
            }
        })
    }

    /**
     * Stop discovering WiFi devices
     *
     * @param call The Method call
     * @param result The Method result
     */
    @Suppress("unused", "UNUSED_PARAMETER")
    fun stopDiscover(call: MethodCall, result: Result) {
        manager.stopPeerDiscovery(channel, object : WifiP2pManager.ActionListener {
            override fun onSuccess() {
                result.success(true)
            }

            override fun onFailure(reasonCode: Int) {
                result.error(reasonCode.toString(), null, null)
            }
        })
    }
    //endregion

    //region Connection

    @Suppress("unused", "UNUSED_PARAMETER")
    fun connect(call: MethodCall, result: Result) {
        val device = Protos.WifiP2pDevice.parseFrom(call.argument<ByteArray>("payload"))

        val config = WifiP2pConfig().apply {
            deviceAddress = device.deviceAddress
        }

        manager.connect(channel, config, object : WifiP2pManager.ActionListener {
            override fun onSuccess() {
                result.success(true)
            }

            override fun onFailure(reasonCode: Int) {
                result.error(reasonCode.toString(), null, null)
            }
        })
    }

    @Suppress("unused", "UNUSED_PARAMETER")
    fun cancelConnect(call: MethodCall, result: Result) {
        manager.cancelConnect(channel, object : WifiP2pManager.ActionListener {
            override fun onSuccess() {
                result.success(true)
            }

            override fun onFailure(reasonCode: Int) {
                result.error(reasonCode.toString(), null, null)
            }
        })
    }

    //endregion

    //region Host Advertising

    @Suppress("unused", "UNUSED_PARAMETER")
    fun openHostPort(call: MethodCall, result: Result) {
        val port = call.argument<Int>("port")
        if (port == null) {
            result.error("Invalid port given", null, null)
            return
        }

        socketPool.openSocket(port)
        result.success(true)
    }

    @Suppress("unused", "UNUSED_PARAMETER")
    fun closeHostPort(call: MethodCall, result: Result) {
        val port = call.argument<Int>("port")
        if (port == null) {
            result.error("Invalid port given", null, null)
            return
        }

        socketPool.closeSocket(port)
        result.success(true)
    }

    @Suppress("unused", "UNUSED_PARAMETER")
    fun acceptPort(call: MethodCall, result: Result) {
        val port = call.argument<Int>("port")
        if (port == null) {
            result.error("Invalid port given", null, null)
            return
        }

        socketPool.acceptClientConnection(port)
        result.success(true)
    }

    //endregion

    //region Client Connection

    @Suppress("unused", "UNUSED_PARAMETER")
    fun connectToHost(call: MethodCall, result: Result) {
        val address = call.argument<String>("address")
        val port = call.argument<Int>("port")
        val timeout = call.argument<Int>("timeout") ?: FlutterP2pPlugin.config.timeout

        if (port == null || address == null) {
            result.error("Invalid address or port given", null, null)
            return
        }

        socketPool.connectToHost(address, port, timeout)
        result.success(true)
    }

    @Suppress("unused", "UNUSED_PARAMETER")
    fun disconnectFromHost(call: MethodCall, result: Result) {
        val port = call.argument<Int>("port")
        if (port == null) {
            result.error("Invalid port given", null, null)
            return
        }
        this.socketPool.disconnectFromHost(port)
        result.success(true)
    }
    //endregion

    //region Data Transfer

    @Suppress("unused", "UNUSED_PARAMETER")
    fun sendDataToHost(call: MethodCall, result: Result) {
        val socketMessage = Protos.SocketMessage.parseFrom(call.argument<ByteArray>("payload"))

        this.socketPool.sendDataToHost(socketMessage.port, socketMessage.data.toByteArray())
        result.success(true)
    }

    @Suppress("unused", "UNUSED_PARAMETER")
    fun sendDataToClient(call: MethodCall, result: Result) {
        val socketMessage = Protos.SocketMessage.parseFrom(call.argument<ByteArray>("payload"))

        this.socketPool.sendDataToClient(socketMessage.port, socketMessage.data.toByteArray())
        result.success(true)
    }

    // endregion

    // endregion

    // region MethodCallHandler
    private val methodMap = HashMap<String, Method>()

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (methodMap.isEmpty()) {
            fetchMethods()
        }

        val method = methodMap[call.method]
        if (null == method) {
            result.notImplemented()
            return
        }

        Log.v(TAG, "Method: " + call.method)
        val args = arrayOfNulls<Any>(2)
        args[0] = call
        args[1] = result

        try {
            method.invoke(this, *args)
        } catch (e: Exception) {
            result.error(call.method, e.message, e)
        }

    }

    private fun fetchMethods() {

        val c = this::class.java
        val m = c.declaredMethods

        for (method in m) {
            methodMap[method.name] = method
        }
    }
    //endregion
}
