import SwiftUI
import OAuthSwift

struct GithubLoginView: View {
    @State private var isLogged = false

    var body: some View {
        VStack{
            if isLogged {
                ContentView()
            } else {
                Button("Login with GitHub") {
                    performGitHubLogin()
                    print("tapped")
                    print(isLogged)
                }
                .padding()
            }
        }
        
        
    }

    private func performGitHubLogin() {
        let oauthswift = OAuth2Swift(
            consumerKey:    "1f5c31cbadf064c8dc39",
            consumerSecret: "9258f67b036a90b2602909fc4bfe477b4bd541f6",
            authorizeUrl: "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType: "code"
        )
        oauthswift.accessTokenBasicAuthentification = true

        oauthswift.authorize(
                    withCallbackURL: URL(string: "Zimran://oauth/github/callback/")!,
                    scope: "user",
                    state: "GITHUB"){ result in
                        switch result {
                        case .success(let (credential, _, _)):
                            print("Access Token: \(credential.oauthToken)")
                            DispatchQueue.main.async {
                                                    self.isLogged = true
                                                }

                            oauthswift.client.get(
                                "https://api.github.com/user"){ result in
                                    switch result {
                                    case .success(let response):
                                        let dataString = response.string
                                        print(self.isLogged)
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                
    }
}

@main
struct GitHubLoginApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
