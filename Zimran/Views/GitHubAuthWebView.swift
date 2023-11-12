import SwiftUI
import OAuthSwift
let oauthswift = OAuth1Swift(
    consumerKey: "your_consumer_key",
    consumerSecret: "your_consumer_secret",
    requestTokenUrl: "https://example.com/oauth/request_token",
    authorizeUrl: "https://example.com/oauth/authorize",
    accessTokenUrl: "https://example.com/oauth/access_token"
)
//oauthswift.authorize(
//    withCallbackURL: URL(string: "oauth-swift://oauth-callback/example")!,
//    success: { credential, response, parameters in
//        print("Token: \(credential.oauthToken)")
//        print("Verifier: \(credential.oauthVerifier)")
//
//        // Now, exchange the request token for an access token
//        oauthswift.client.credential.oauthTokenSecret = credential.oauthTokenSecret
//        oauthswift.post(
//            "https://example.com/oauth/access_token",
//            success: { response in
//                let parameters = response.string?.parametersFromQueryString()
//                let accessToken = parameters?["oauth_token"]
//                let accessTokenSecret = parameters?["oauth_token_secret"]
//
//                print("Access Token: \(accessToken ?? "")")
//                print("Access Token Secret: \(accessTokenSecret ?? "")")
//            },
//            failure: { error in
//                print("Error retrieving access token: \(error.localizedDescription)")
//            }
//        )
//    },
//    failure: { error in
//        print("Error: \(error.localizedDescription)")
//    }
//)


//struct GitHubAuthWebView: UIViewRepresentable {
//    @Binding var isShowingWebView: Bool
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIView(context: Context) -> UIView {
//        let webView = OAuth2SwiftWebViewController(url: URL(string: "https://github.com/login/oauth/authorize")!)
//        webView.viewController = UIApplication.shared.windows.first?.rootViewController
//        webView.delegate = context.coordinator
//        return webView.view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {}
//
//    class Coordinator: NSObject, OAuthSwiftWebViewDelegate {
//        var parent: GitHubAuthWebView
//
//        init(parent: GitHubAuthWebView) {
//            self.parent = parent
//        }
//
//        func oauthSwiftWebViewDidCancel(_ controller: OAuthSwiftWebViewController) {
//            parent.isShowingWebView = false
//        }
//    }
//}
