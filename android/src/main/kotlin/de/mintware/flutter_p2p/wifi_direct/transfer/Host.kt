/*
 * This file is part of the flutter_p2p package.
 *
 * Copyright 2019 by Julian Finkler <julian@mintware.de>
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code.
 *
 */

package de.mintware.flutter_p2p.wifi_direct.transfer

import de.mintware.flutter_p2p.StreamHandler
import java.net.ServerSocket

class Host(val serverSocket: ServerSocket,
           inputStreamHandler: StreamHandler
) : SocketTask(inputStreamHandler) {

    private lateinit var handler: SocketHandler

    override fun doInBackground(vararg params: Void?): Boolean {

        try {
            socket = serverSocket.accept()
            handler = SocketHandler(socket, true)
            handler.handleInput { data -> publishProgress(data) }
        } catch (e: Exception) {
            e.printStackTrace()
            return false
        }

        return true
    }

}