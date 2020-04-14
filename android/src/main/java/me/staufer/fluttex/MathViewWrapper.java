package me.staufer.fluttex;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.View;

import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;
import me.staufer.textools.MathView;

/**
 * Wrapper class for MathView from me.staufer.textools
 */
public class MathViewWrapper implements PlatformView, MethodChannel.MethodCallHandler {
    private MathView mathView;
    private MethodChannel methodChannel;

    /**
     * @param context   Context of view
     * @param messenger BinaryMessenger for communication
     * @param id        of view
     * @param options   for MathView instance
     */
    public MathViewWrapper(Context context, BinaryMessenger messenger, int id, Object options) {
        //parse colors if options have been passed correctly
        if (options instanceof Map) {
            parseColor((Map) options, "color");
            parseColor((Map) options, "backgroundColor");
            parseColor((Map) options, "errorColor");

            mathView = new MathView(context, (Map) options);
        } else mathView = new MathView(context, (AttributeSet) null);

        //register MethodChannel and handler
        methodChannel = new MethodChannel(messenger, String.format("MathView:%s", id));
        methodChannel.setMethodCallHandler(this);
    }

    /**
     * method call handler
     *
     * @param call   MethodCall
     * @param result of the call
     */
    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        if ("render".equals(call.method)) {
            //render
            render(call, result);
        } else {
            result.notImplemented();
        }
    }

    /**
     * get the current MathView instance
     *
     * @return MathView instance
     */
    @Override
    public View getView() {
        return mathView;
    }

    /**
     * dispose of MathView
     */
    @Override
    public void dispose() {
    }

    /**
     * render the TeX passed in the call arguments
     *
     * @param call   render MethodCall
     * @param result of the render call
     */
    private void render(MethodCall call, MethodChannel.Result result) {
        String tex = (String) call.arguments;
        mathView.render(tex);
        result.success(null);
    }

    /**
     * helper method to parse the Flutter color string to a Color instance
     * by overwriting the color at the key
     *
     * @param map Map of options
     * @param key key of the color to be parsed
     */
    private static void parseColor(Map<String, Object> map, String key) {
        map.put(key, Color.parseColor((String) map.get(key)));
    }

}
