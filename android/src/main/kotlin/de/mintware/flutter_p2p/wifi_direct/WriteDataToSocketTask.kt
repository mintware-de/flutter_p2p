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

import android.os.AsyncTask
import java.net.Socket

class WriteDataToSocketTask(private val socket: Socket,
                            private val data: ByteArray
) : AsyncTask<Void, Void, Boolean?>() {

    override fun doInBackground(vararg params: Void?): Boolean? {
        if (!socket.isClosed) {
//            return false;
        }

        socket.getOutputStream().write(data);
        socket.getOutputStream().flush();
        return true;
    }
}