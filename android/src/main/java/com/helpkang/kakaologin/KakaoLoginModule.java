package com.helpkang.kakaologin;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.helpkang.kakaologin.mo.ReactKakaoLogin;
import com.kakao.auth.Session;

public class KakaoLoginModule extends ReactContextBaseJavaModule implements ActivityEventListener {

    private ReactKakaoLogin rkl;

    public KakaoLoginModule(ReactApplicationContext reactContext) {
        super(reactContext);
        initKakao();
    }

    @ReactMethod
    public void login(Promise promise){
//        initKakao();
        rkl.login(promise);
    }

    @ReactMethod
    public void logout(Promise promise){
//        initKakao();
        rkl.logout(promise);
    }

    public void initKakao(){
        if( this.rkl  != null) return;
        ReactApplicationContext reactContext = getReactApplicationContext();
        reactContext.addActivityEventListener(this);

//        Log.d("current context", reactContext.toString());
//
//        Log.d("current Activity", reactContext.getCurrentActivity().toString());

        this.rkl = new ReactKakaoLogin(reactContext);
    }


    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
        if (Session.getCurrentSession().handleActivityResult(requestCode, resultCode, data)){
            return;
        }
    }


    @Override
    public void onNewIntent(Intent intent) {
    }

    @Override
    public String getName() {
        return "KakaoLoginModule";
    }
}
