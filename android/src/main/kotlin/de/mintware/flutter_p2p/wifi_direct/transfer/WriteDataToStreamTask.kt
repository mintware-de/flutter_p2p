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
import java.io.OutputStream

class WriteDataToStreamTask(private val stream: OutputStream,
                            private val bytes: ByteArray
) : AsyncTask<Void, Void, Boolean>() {

    override fun doInBackground(vararg params: Void?): Boolean {
        stream.write(bytes)
        stream.flush()
        return true;
    }

}