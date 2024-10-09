import Foundation
import Capacitor

import NaverThirdPartyLogin

import Alamofire

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(naverLoginPlugin)
public class naverLoginPlugin: CAPPlugin {

    // 전역 (?)
    var capPluginCall: CAPPluginCall?
    var initSwitch: Bool = false



    @objc func naverLogin(_ call: CAPPluginCall) {
            self.capPluginCall = call

                    if !initSwitch {


                                    guard let serviceUrlScheme = call.getString("serviceUrlScheme") else {
                call.reject("serviceUrlScheme not provided")
                return
            }

    
                                 guard let naverClientId = call.getString("naverClientId") else {
                call.reject("naverClientId not provided")
                return
            }


                             guard let naverClientSecret = call.getString("naverClientSecret") else {
                call.reject("naverClientSecret not provided")
                return
            }


                             guard let naverClientName = call.getString("naverClientName") else {
                call.reject("naverClientName not provided")
                return
            }


        // for Naver Setting
        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return  }
                        loginInstance.isNaverAppOauthEnable = true
                        loginInstance.isInAppOauthEnable = true
                        loginInstance.serviceUrlScheme = serviceUrlScheme
                        loginInstance.consumerKey = naverClientId
                        loginInstance.consumerSecret = naverClientSecret
                        loginInstance.appName = naverClientName

                // for Naver Delegate 사용
                        loginInstance.delegate = self;
                        
                
                initSwitch = true;
            }
            

        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return  }

            // 이미 로그인되어 있는 경우
            if loginInstance.isValidAccessTokenExpireTimeNow() {
                self.naverUserInfo(call)
            }
            
            // 없는 경우 naver App! => 앱이 없는 경우 자동으로 webview 열려요 :)
            loginInstance.requestThirdPartyLogin()



    }




        //  naver info 가져올 때 reseponse 형식
        struct NaverLogin: Decodable {
            let resultcode: String
            let message: String
            let response: Response?
            
            struct Response: Decodable {
                let id: String
                let email: String
                let name :String?
            }

            private enum CodingKeys: String, CodingKey {
                case resultcode
                case message
                case response
            }
        }
        

    // get Naver Info
public func naverUserInfo(_ call: CAPPluginCall) {
    guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
    guard let tokenType = loginInstance.tokenType else { return }
    guard let accessToken = loginInstance.accessToken else { return }

    let urlStr = "https://openapi.naver.com/v1/nid/me"
    let url = URL(string: urlStr)!
    let authorization = "\(tokenType) \(accessToken)"

    let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
    
    AF.request(url, method: .get, headers: ["Authorization": authorization])
        .validate()
        .responseDecodable(of: NaverLogin.self) { response in
            switch response.result {
            case .success(let data):
                print("Response Data: \(data)")
            case .failure(let error):
                print("Error: \(error)")
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Server Response: \(str)")
                }
            }
        }
    
    
    req.responseDecodable(of: NaverLogin.self) {response in
    
        
        switch response.result {
            
            
            
            // 성공시
        case .success(let loginData):
            if let email = loginData.response?.email {
                call.resolve(["email": email])
            } else {
                // 예기치 않은 응답 또는 response가 nil인 경우 처리
                call.reject("Unexpected response or email not found")
            }
            // 실패!
        case .failure(let error):
            call.reject(error.localizedDescription)
        }
    }
}
}


// Naver Delegate
extension naverLoginPlugin: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공한 경우 호출
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        guard let call = self.capPluginCall else { return }
        naverUserInfo(call)
    }
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    }
    
    public func oauth20ConnectionDidFinishDeleteToken() {
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    }
}
