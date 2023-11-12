import SwiftUI
import OAuthSwift

struct GithubLoginView: View {
    @State private var isLogged = false

    var body: some View {
        if isLogged {
            ContentView()
        } else {
            Button("Login with GitHub") {
                performGitHubLogin()
                print("tapped")
            }
            .padding()
        }
    }

    private func performGitHubLogin() {
        let oauthswift = OAuth2Swift(
            consumerKey:    "1f5c31cbadf064c8dc39",
            consumerSecret: "b5b08d330d88a4889b59f5761a5ce47b1e146357",
            authorizeUrl: "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType: "code"
        )
        oauthswift.authorize(
                    withCallbackURL: URL(string: "Zimran://")!,
                    scope: "user",
                    state: "your_state",
                    completionHandler: { result in
                        switch result {
                        case .success(let (credential, _, _)):
                            print("Access Token: \(credential.oauthToken)")
                            
                            oauthswift.client.get(
                                "https://api.github.com/user"){ result in
                                    switch result {
                                    case .success(let response):
                                        self.isLogged = true
                                        let dataString = response.string
                                        print(dataString)
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                )
    }
}


struct GitHubLoginApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
