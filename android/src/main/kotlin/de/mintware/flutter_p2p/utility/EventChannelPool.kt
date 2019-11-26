/*
 * This file is part of the flutter_p2p package.
 *
 * Copyright 2019 by Julian Finkler <julian@mintware.de>
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code.
 *
 */

package de.mintware.flutter_p2p.utility

import de.mintware.flutter_p2p.StreamHandler
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import java.lang.Error

class EventChannelPool(private val messenger: BinaryMessenger
) {
    private val base = "de.mintware.flutter_p2p"
    private val eventChannels = HashMap<String, StreamHandler>()

    fun register(name: String): StreamHandler {
        if (isRegistered(name)) {
            throw Error("A channel with this name already exists.")
        }

        val channel = EventChannel(messenger, "${base}/${name}")
        eventChannels[name] = StreamHandler.createForChannel(channel)
        return eventChannels[name]!!
    }

    fun getHandler(name: String): StreamHandler {
        if (!isRegistered(name)) {
            throw Error("A channel with this name does not exist.")
        }
        return eventChannels[name]!!
    }

    private fun isRegistered(name: String): Boolean {
        return eventChannels.containsKey(name)
    }
}