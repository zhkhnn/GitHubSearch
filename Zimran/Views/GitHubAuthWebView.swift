//import SwiftUI
//import OAuthSwift
//
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
