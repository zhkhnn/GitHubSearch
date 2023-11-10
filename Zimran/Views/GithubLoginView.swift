import SwiftUI
import OAuthSwift

struct GitHubLoginView: View {
    @State private var isShowingWebView = false

    var body: some View {
        VStack {
            Button("Login with GitHub") {
                isShowingWebView.toggle()
            }
        }
//        .sheet(isPresented: $isShowingWebView) {
//            GitHubAuthWebView(isShowingWebView: $isShowingWebView)
//        }
    }
}

