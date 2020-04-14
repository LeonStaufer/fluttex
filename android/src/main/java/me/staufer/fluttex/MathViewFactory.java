package me.staufer.fluttex;

import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * PlatformViewFactory to create the MathView
 */
public class MathViewFactory extends PlatformViewFactory {
    private BinaryMessenger messenger;

    /**
     * constructor for MathViewFactory
     *
     * @param binaryMessenger messenger between Flutter and MathView instance
     */
    public MathViewFactory(BinaryMessenger binaryMessenger) {
        super(StandardMessageCodec.INSTANCE);

        messenger = binaryMessenger;
    }

    /**
     * create a MathView
     *
     * @param context Context of the view
     * @param viewId  Id of the PlatformView
     * @param args    arguments for MathView instance
     * @return PlatformView of type MathView
     */
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new MathViewWrapper(context, messenger, viewId, args);
    }
}
