package local.pica.pica_reader

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Small replacement for path_provider: that plugin needs symlink support
        // at build time, this channel does not.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "pica_reader/paths")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getFilesDir" -> result.success(filesDir.absolutePath)
                    "exportToDownloads" -> {
                        val path = call.argument<String>("path")
                        if (path.isNullOrEmpty()) {
                            result.error("bad_args", "缺少文件路径", null)
                            return@setMethodCallHandler
                        }
                        val name = call.argument<String>("name") ?: File(path).name
                        try {
                            result.success(exportToDownloads(File(path), name))
                        } catch (error: Exception) {
                            result.error("export_failed", error.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Copies a downloaded CBZ into the shared Download folder.
     *
     * API 29+ goes through MediaStore, which needs no runtime permission at all;
     * older versions fall back to the app's external files folder, also
     * permission free. Nothing here ever asks for WRITE_EXTERNAL_STORAGE.
     */
    private fun exportToDownloads(file: File, relativeName: String): String {
        if (!file.exists()) throw IllegalStateException("文件不存在：${file.name}")

        val parts = relativeName.replace('\\', '/').split('/').filter { it.isNotEmpty() }
        val displayName = parts.lastOrNull() ?: file.name
        val subFolder = parts.dropLast(1).joinToString("/")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val relativePath = Environment.DIRECTORY_DOWNLOADS + "/pica_reader" +
                if (subFolder.isEmpty()) "" else "/$subFolder"
            val values = ContentValues().apply {
                put(MediaStore.Downloads.DISPLAY_NAME, displayName)
                put(MediaStore.Downloads.MIME_TYPE, "application/vnd.comicbook+zip")
                put(MediaStore.Downloads.RELATIVE_PATH, relativePath)
                put(MediaStore.Downloads.IS_PENDING, 1)
            }
            val resolver = contentResolver
            val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                ?: throw IllegalStateException("系统拒绝了写入请求")
            try {
                val output = resolver.openOutputStream(uri)
                    ?: throw IllegalStateException("无法打开目标文件")
                output.use { sink ->
                    file.inputStream().use { source -> source.copyTo(sink) }
                }
                values.clear()
                values.put(MediaStore.Downloads.IS_PENDING, 0)
                resolver.update(uri, values, null, null)
            } catch (error: Exception) {
                // A pending item left behind shows up as a truncated file.
                resolver.delete(uri, null, null)
                throw error
            }
            return uri.toString()
        }

        @Suppress("DEPRECATION")
        val directory = File(
            getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS),
            "pica_reader" + if (subFolder.isEmpty()) "" else "/$subFolder",
        )
        directory.mkdirs()
        val target = File(directory, displayName)
        file.inputStream().use { source ->
            target.outputStream().use { sink -> source.copyTo(sink) }
        }
        return target.absolutePath
    }
}
