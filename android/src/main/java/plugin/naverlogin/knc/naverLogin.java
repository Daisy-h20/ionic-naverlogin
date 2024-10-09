package plugin.naverlogin.knc;

import android.os.Bundle;
import com.getcapacitor.BridgeActivity;


public class naverLogin extends BridgeActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        registerPlugin(naverLoginPlugin.class);
        super.onCreate(savedInstanceState);
    }
}
