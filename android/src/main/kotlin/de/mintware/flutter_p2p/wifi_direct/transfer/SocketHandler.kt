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

import de.mintware.flutter_p2p.FlutterP2pPlugin
import de.mintware.flutter_p2p.utility.ProtoHelper
import java.io.InputStream
import java.net.Socket

class SocketHandler(private val socket: Socket,
                    private val isHost: Boolean
) {
    private val inputStream: InputStream = socket.getInputStream();

    fun handleInput(cb: (data: ByteArray) -> Unit) {
        val buf = ByteArray(FlutterP2pPlugin.config.bufferSize)

        var readCount = 0;

        val port = if (isHost) socket.localPort else (socket.port)
        while ({ readCount = inputStream.read(buf);readCount }() != -1) {
            val result = ProtoHelper.create(port, buf.take(readCount).toByteArray(), inputStream.available())
            cb(result.toByteArray())
        }
    }
}