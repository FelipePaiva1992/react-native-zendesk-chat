package com.taskrabbit.zendesk;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.zopim.android.sdk.api.ZopimChat;
import com.zopim.android.sdk.model.VisitorInfo;
import com.zopim.android.sdk.prechat.*;

import java.lang.String;

public class RNZendeskChatModule extends ReactContextBaseJavaModule {
    private final static String MODULE_NAME = "RNZendeskChatModule";
    private final static String NAME_KEY = "name";
    private final static String EMAIL_KEY = "email";
    private final static String PHONE_KEY = "phone";

    private ReactContext mReactContext;

    public RNZendeskChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mReactContext = reactContext;
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @ReactMethod
    public void setVisitorInfo(ReadableMap options) {
        VisitorInfo.Builder builder = new VisitorInfo.Builder();

        if (options.hasKey(NAME_KEY)) {
            builder.name(options.getString(NAME_KEY));
        }
        if (options.hasKey(EMAIL_KEY)) {
            builder.email(options.getString(EMAIL_KEY));
        }
        if (options.hasKey(PHONE_KEY)) {
            builder.phoneNumber(options.getString(PHONE_KEY));
        }

        VisitorInfo visitorData = builder.build();

        ZopimChat.setVisitorInfo(visitorData);
    }

    @ReactMethod
    public void init(String key) {
        ZopimChat.init(key).emailTranscript(EmailTranscript.DISABLE);;
    }

    @ReactMethod
    public void startChat(ReadableMap options) {
        setVisitorInfo(options);
        Activity activity = getCurrentActivity();
        if (activity != null) {
            activity.startActivity(new Intent(mReactContext, ZopimChatActivity.class));
        }
    }
}
