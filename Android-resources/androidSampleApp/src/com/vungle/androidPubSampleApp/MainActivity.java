package com.vungle.androidPubSampleApp;

import android.app.Activity;
import android.os.Bundle;
import com.vungle.publisher.VunglePub;
import android.widget.Button;
import android.view.View;
import com.vungle.publisher.EventListener;
import android.util.Log;
import com.vungle.publisher.AdConfig;

public class MainActivity extends Activity {

    // get the VunglePub instance
    final VunglePub vunglePub = VunglePub.getInstance();

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        // get your App ID from the app's main page on the Vungle Dashboard after setting up your app
        final String app_id = "vungleTest";

        // initialize the Publisher SDK
        vunglePub.init(this, app_id);

        vunglePub.setEventListener(vungleListener);

        //PLAY AD WITH DEFAULT OPTIONS

        Button playBtnDef = (Button) findViewById(R.id.play_btn_def);
        playBtnDef.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                vunglePub.playAd();
            }
        });

        // PLAY AD WITH CUSTOM OPTIONS

        // create a new AdConfig object
        final AdConfig overrideConfig = new AdConfig();

        // set any configuration options you like.
        overrideConfig.setIncentivized(true);
        overrideConfig.setSoundEnabled(false);

        Button playBtnOpt = (Button) findViewById(R.id.play_btn_opt);
        playBtnOpt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // the overrideConfig object will only affect this ad play.
                vunglePub.playAd(overrideConfig);
            }
        });

    }

    private final EventListener vungleListener = new EventListener(){

        @Override
        public void onVideoView(boolean isCompletedView, int watchedMillis, int videoDurationMillis) {
            // Called each time a video completes. isCompletedView is true if the video was not skipped.
        }

        @Override
        public void onAdStart() {
            // Called before playing an ad
        }

        @Override
        public void onAdEnd() {
            // Called when the user leaves the ad and control is returned to your application
        }

        @Override
        public void onCachedAdAvailable() {
            // Called when ad is downloaded and ready to be played
            Log.i("jordyn","cachedAdAvail");
        }

    };

    @Override
    protected void onPause() {
        super.onPause();
        vunglePub.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        vunglePub.onResume();
    }

}
