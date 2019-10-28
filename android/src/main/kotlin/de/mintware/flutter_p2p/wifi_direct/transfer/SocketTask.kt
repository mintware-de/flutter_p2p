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

import android.os.AsyncTask
import de.mintware.flutter_p2p.StreamHandler
import java.net.Socket

abstract class SocketTask(private val inputStreamHandler: StreamHandler) : AsyncTask<Void, ByteArray, Boolean>() {

    lateinit var socket: Socket

    override fun onProgressUpdate(vararg values: ByteArray?) {
        inputStreamHandler.sink?.success(values[0])
    }

    fun writeToOutput(bytes: ByteArray): Boolean {
        try {
            val task = WriteDataToStreamTask(socket.getOutputStream(), bytes)
            task.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return true;
    }
}