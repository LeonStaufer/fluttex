package me.staufer.fluttex;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FluttexPlugin
 */
public class FluttexPlugin implements FlutterPlugin, MethodCallHandler {
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "fluttex");
        channel.setMethodCallHandler(new FluttexPlugin());

        //register MathView PlatformViewFactory
        flutterPluginBinding.getPlatformViewRegistry()
                .registerViewFactory("mathview", new MathViewFactory(flutterPluginBinding.getBinaryMessenger()));
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "fluttex");
        channel.setMethodCallHandler(new FluttexPlugin());

        //register MathView PlatformViewFactory
        registrar.platformViewRegistry()
                .registerViewFactory("mathview", new MathViewFactory(registrar.messenger()));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}
