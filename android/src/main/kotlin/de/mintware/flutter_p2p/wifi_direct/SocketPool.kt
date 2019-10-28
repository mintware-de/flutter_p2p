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

import de.mintware.flutter_p2p.StreamHandler
import de.mintware.flutter_p2p.wifi_direct.transfer.Client
import de.mintware.flutter_p2p.wifi_direct.transfer.Host
import java.net.ServerSocket

class SocketPool(private val inputStreamHandler: StreamHandler) {

    private val clientPool = mutableListOf<Client>()
    private val hosts = mutableListOf<Host>()

    fun openSocket(port: Int): Host {
        if (getHostByPort(port) != null) {
            throw Exception("A socket with this port already exist")
        }

        val socket = ServerSocket(port)

        val host = Host(socket, inputStreamHandler)
        hosts.add(host)

        return host
    }

    fun acceptClientConnection(port: Int) {
        val host: Host = getHostByPort(port)
                ?: throw Exception("A socket with this port is not registered.")
        host.execute()
    }

    fun closeSocket(port: Int) {
        val socket: Host = getHostByPort(port)
                ?: throw Exception("A socket with this port is not registered.")
        socket.serverSocket.close()
    }

    fun connectToHost(address: String, port: Int, timeout: Int): Client {
        val client = Client(address, port, inputStreamHandler, timeout)
        clientPool.add(client)
        client.execute()

        return client
    }

    fun sendDataToHost(port: Int, data: ByteArray) {
        val client: Client = getClientByPort(port)
                ?: throw Exception("A socket with this port is not connected.")

        try {
            client.writeToOutput(data)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun sendDataToClient(port: Int, data: ByteArray) {
        val host: Host = getHostByPort(port)
                ?: throw Exception("A socket with this port is not connected.")

        host.writeToOutput(data)
    }

    fun disconnectFromHost(port: Int) {
        val client: Client = getClientByPort(port)
                ?: throw Exception("A socket with this port is not connected.")

        client.socket.takeIf { it.isConnected }?.apply {
            close()
        }
    }

    fun disconnectFromClient(port: Int) {
        val host: Host = getHostByPort(port)
                ?: throw Exception("A socket with this port is not connected.")

        host.serverSocket.takeIf { !it.isClosed }?.apply {
            close()
        }
    }

    private fun getHostByPort(port: Int): Host? {
        return hosts.firstOrNull { s -> s.serverSocket.localPort == port }
    }


    private fun getClientByPort(port: Int): Client? {
        return clientPool.firstOrNull { s -> s.port == port }
    }
}