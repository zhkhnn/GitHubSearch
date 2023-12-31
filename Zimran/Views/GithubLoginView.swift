import SwiftUI
import OAuthSwift

struct GithubLoginView: View {
    @State private var isLogged = false
    

    var body: some View {
        VStack{
            if isLogged {
                ContentView()
            } else {
                ZStack{
                    Image("meme")
                                .resizable()
                                .edgesIgnoringSafeArea(.all)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .clipped()
                    VStack{
                        Spacer()
                        Button("Login with GitHub") {
                            performGitHubLogin()
                        }
                        .foregroundColor(.white)
                        .padding(15)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 180/255, green: 173/255, blue: 163/255), Color(red: 120/255, green: 113/255, blue: 103/255)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                }
                
            }
        }
        
        
        
    }
    let oauthswift = OAuth2Swift(
        consumerKey:    "1f5c31cbadf064c8dc39",
        consumerSecret: "9258f67b036a90b2602909fc4bfe477b4bd541f6",
        authorizeUrl: "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType: "token"
    )
    private func performGitHubLogin() {
        
        oauthswift.accessTokenBasicAuthentification = true
        self.isLogged = true

        oauthswift.authorize(
                    withCallbackURL: URL(string: "Zimran://")!,
                    scope: "user",
                    state: "GITHUB"){ result in
                        print("in ")
                        switch result {
                        case .success(let (credential, _, _)):
                            print("Access Token: \(credential.oauthToken)")
                            print("Setting isLogged to true")
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
    func logOut() {
            // Assuming OAuthSwiftClient is the client you obtained during login
            // Revoking the token might not be supported by all OAuth providers
            oauthswift.client.credential.oauthToken = ""
            self.isLogged = false
        }
}

@main
struct GitHubLoginApp: App {
    var body: some Scene {
        WindowGroup {
            GithubLoginView()
        }
    }
}
