package com.zkty.hybrid.activity;

import android.content.Context;
import android.hardware.fingerprint.FingerprintManager;
import android.os.Build;
import android.os.Bundle;
import android.os.CancellationSignal;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.hybrid.R;

public class FingerprintActivity extends AppCompatActivity {
    private static final String TAG = FingerprintActivity.class.getSimpleName();


    private FingerprintManager fingerprintManager;
    private CancellationSignal cancellationSignal;

    private boolean processing;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fingerprint_layout);
        findViewById(R.id.start).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    fingerprintManager = (FingerprintManager) getSystemService(Context.FINGERPRINT_SERVICE);
                    if (fingerprintManager.isHardwareDetected()) {
                        Log.d(TAG, "detected!");

                        if (fingerprintManager.hasEnrolledFingerprints()) {
                            Log.d(TAG, "hasEnrolledFingerprints");

                            cancellationSignal = new CancellationSignal();
                            fingerprintManager.authenticate(null, cancellationSignal, 0, new FingerprintManager.AuthenticationCallback() {

                                /**
                                 *
                                 * @param errorCode
                                 * @param errString
                                 */
                                @Override
                                public void onAuthenticationError(int errorCode, CharSequence errString) {
                                    super.onAuthenticationError(errorCode, errString);

                                    Log.d(TAG, "error:" + errorCode + "----" + errString);
                                    if (errorCode == FingerprintManager.FINGERPRINT_ERROR_LOCKOUT) {
                                        processing = false;
                                    }
                                }

                                /**
                                 * 2020-09-30 13:46:23.236 27369-27369/com.zkty.hybrid D/MainActivity: detected!
                                 * 2020-09-30 13:46:23.236 27369-27369/com.zkty.hybrid D/MainActivity: hasEnrolledFingerprints      1
                                 * 2020-09-30 13:46:23.300 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1021----
                                 * 2020-09-30 13:46:25.490 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1022----
                                 * 2020-09-30 13:46:25.895 27369-27369/com.zkty.hybrid D/MainActivity: onAuthenticationFailed       2
                                 * 2020-09-30 13:46:26.095 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1023----
                                 * 2020-09-30 13:46:28.624 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1022----
                                 * 2020-09-30 13:46:29.242 27369-27369/com.zkty.hybrid D/MainActivity: onAuthenticationFailed       3
                                 * 2020-09-30 13:46:29.394 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1023----
                                 * 2020-09-30 13:46:32.129 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1022----
                                 * 2020-09-30 13:46:32.649 27369-27369/com.zkty.hybrid D/MainActivity: onAuthenticationFailed       4
                                 * 2020-09-30 13:46:32.861 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1023----
                                 * 2020-09-30 13:46:39.612 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1022----
                                 * 2020-09-30 13:46:40.141 27369-27369/com.zkty.hybrid D/MainActivity: onAuthenticationFailed       5
                                 * 2020-09-30 13:46:40.284 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1023----
                                 * 2020-09-30 13:46:41.383 27369-27369/com.zkty.hybrid D/MainActivity: helpCode:1022----
                                 * 2020-09-30 13:46:41.852 27369-27369/com.zkty.hybrid D/MainActivity: onAuthenticationFailed       6
                                 * 2020-09-30 13:46:41.872 27369-27369/com.zkty.hybrid D/MainActivity: error:7----尝试次数过多，请稍后重试。
                                 * @param helpCode
                                 * @param helpString
                                 */
                                @Override
                                public void onAuthenticationHelp(int helpCode, CharSequence helpString) {
                                    super.onAuthenticationHelp(helpCode, helpString);
                                    Log.d(TAG, "helpCode:" + helpCode + "----" + helpString);
                                }

                                @Override
                                public void onAuthenticationSucceeded(FingerprintManager.AuthenticationResult result) {
                                    super.onAuthenticationSucceeded(result);
                                    processing = false;
                                    Log.d(TAG, "success:");
                                }

                                @Override
                                public void onAuthenticationFailed() {
                                    super.onAuthenticationFailed();
                                    Log.d(TAG, "onAuthenticationFailed");

                                }
                            }, null);

                            processing = true;
                        } else {
                            Log.d(TAG, "no hasEnrolledFingerprints");
                        }
                    } else {
                        Log.d(TAG, "no detected!");
                    }

                } else {
                    Log.d(TAG, "system not support!");
                }
            }
        });
    }

    @Override
    protected void onStop() {
        super.onStop();
        if (processing && cancellationSignal != null && !cancellationSignal.isCanceled()) {
            cancellationSignal.cancel();
            Log.d(TAG, "cancel!");
        }
    }
}
