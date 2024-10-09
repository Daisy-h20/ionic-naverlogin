package plugin.naverlogin.knc;

import android.app.Activity;
import android.util.Log;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.navercorp.nid.NaverIdLoginSDK;
import com.navercorp.nid.oauth.NidOAuthLogin;
import com.navercorp.nid.oauth.OAuthLoginCallback;
import com.navercorp.nid.profile.NidProfileCallback;
import com.navercorp.nid.profile.data.NidProfile;
import com.navercorp.nid.profile.data.NidProfileResponse;

@CapacitorPlugin(name = "naverLogin")
public class naverLoginPlugin extends Plugin {

    @PluginMethod
    public void naverLogin(PluginCall call) {
        var naverClientId = call.getString("naverClientId");
        var naverClientSecret = call.getString("naverClientSecret");
        var naverClientName = call.getString("naverClientName");

        OAuthLoginCallback oauthLoginCallback = new OAuthLoginCallback() {
            @Override
            public void onSuccess() {
                String naverToken = NaverIdLoginSDK.INSTANCE.getAccessToken();

                NidOAuthLogin nidOAuthLogin = new NidOAuthLogin();
                nidOAuthLogin.callProfileApi(
                    new NidProfileCallback() {
                        @Override
                        public void onSuccess(Object naverInfo) {
                            NidProfileResponse profileResponse = (NidProfileResponse) naverInfo;
                            NidProfile profile = profileResponse.getProfile();

                            String email = profile.getEmail();

                            JSObject ret = new JSObject();
                            ret.put("email", email);
                            call.resolve(ret);
                        }

                        @Override
                        public void onFailure(int httpStatus, String message) {
                            call.reject("error::" + message);
                        }

                        @Override
                        public void onError(int errorCode, String message) {
                            onFailure(errorCode, message);
                        }
                    }
                );
            }

            @Override
            public void onFailure(int httpStatus, String message) {
                call.reject("error::" + message);
            }

            @Override
            public void onError(int errorCode, String message) {
                onFailure(errorCode, message);
            }
        };
        NaverIdLoginSDK.INSTANCE.initialize(super.getActivity(), naverClientId, naverClientSecret, naverClientName);
        NaverIdLoginSDK.INSTANCE.authenticate(super.getActivity(), oauthLoginCallback);
    }
}
