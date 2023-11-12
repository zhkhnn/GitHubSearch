import SwiftUI
import OAuthSwift

struct GithubLoginView: View {
    @State private var isLogged = false

    var body: some View {
        if isLogged {
            Text("Logged in!")
        } else {
            Button("Login with GitHub") {
                performGitHubLogin()
                print("tapped")
            }
            .padding()
        }
    }

    private func performGitHubLogin() {
//        guard let url = URL(string: "https://github.com/login/oauth/authorize") else { return }

        let oauthswift = OAuth2Swift(
            consumerKey:    "1f5c31cbadf064c8dc39",
            consumerSecret: "5ff87e573c01cf7226be4fa7b7f2ed009f53b927",
            authorizeUrl: "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType: "code"
        )
        oauthswift.authorize(
                    withCallbackURL: URL(string: "Aruzhan-Zhakhan.Zimran://callback")!,
                    scope: "user",
                    state: "your_state",
                    completionHandler: { result in
                        switch result {
                        case .success(let (credential, _, _)):
                            print("Access Token: \(credential.oauthToken)")
                            self.isLogged = true
                            oauthswift.client.get(
                                "https://api.github.com/user"){ result in
                                    switch result {
                                    case .success(let response):
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
