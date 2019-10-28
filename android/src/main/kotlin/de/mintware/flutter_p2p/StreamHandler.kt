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

import io.flutter.plugin.common.EventChannel

class StreamHandler : EventChannel.StreamHandler {

    companion object {
        internal fun createForChannel(channel: EventChannel): StreamHandler {
            val handler = StreamHandler()
            handler.channel = channel
            channel.setStreamHandler(handler)
            return handler
        }
    }

    var channel: EventChannel? = null
    var sink: EventChannel.EventSink? = null

    override fun onListen(o: Any?, eventSink: EventChannel.EventSink?) {
        sink = eventSink
    }

    override fun onCancel(o: Any?) {
        sink = null
    }
}