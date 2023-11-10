//
//  Authorization.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 09.11.2023.
//

import Foundation
struct Authorization{
    func githubLogin(){
        let uuid = UUID().uuidString
        let authURLFull = "https://github.com/login/oauth/authorize?client_id=" + GithubConstants.CLIENT_ID + "&scope=" + GithubConstants.SCOPE + "&redirect_uri=" + GithubConstants.REDIRECT_URI + "&state=" + uuid
        let urlRequest = URLRequest(url: URL(string: authURLFull)!)
    }
    func githubRequestForAccessToken(authCode: String) {
            let grantType = "authorization_code"

            // Set the POST parameters.
            let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + GithubConstants.CLIENT_ID + "&client_secret=" + GithubConstants.CLIENT_SECRET
            let postData = postParams.data(using: String.Encoding.utf8)
            let request = NSMutableURLRequest(url: URL(string: GithubConstants.TOKENURL)!)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, _) -> Void in
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                    let accessToken = results?["access_token"] as! String
                    // Get user's id, display name, email, profile pic url
                    self.fetchGitHubUserProfile(accessToken: accessToken)
                }
            }
            task.resume()
        }
    func fetchGitHubUserProfile(accessToken: String) {
            let tokenURLFull = "https://api.github.com/user"
            let verify: NSURL = NSURL(string: tokenURLFull)!
            let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
                if error == nil {
                    let result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                    // AccessToken
                    print("GitHub Access Token: \(accessToken)")
                    // GitHub Handle
                    let githubId: Int! = (result?["id"] as! Int)
                    print("GitHub Id: \(githubId ?? 0)")
                    // GitHub Display Name
                    let githubDisplayName: String! = (result?["login"] as! String)
                    print("GitHub Display Name: \(githubDisplayName ?? "")")
                    // GitHub Email
                    let githubEmail: String! = (result?["email"] as! String)
                    print("GitHub Email: \(githubEmail ?? "")")
                    // GitHub Profile Avatar URL
                    let githubAvatarURL: String! = (result?["avatar_url"] as! String)
                    print("github Profile Avatar URL: \(githubAvatarURL ?? "")")
//                    DispatchQueue.main.async {
//                        self.performSegue(withIdentifier: "detailseg", sender: self)
//                    }
                }
            }
            task.resume()
        }
    func RequestForCallbackURL(request: URLRequest) {
            // Get the authorization code string after the '?code=' and before '&state='
            let requestURLString = (request.url?.absoluteString)! as String
            print(requestURLString)
            if requestURLString.hasPrefix(GithubConstants.REDIRECT_URI) {
                if requestURLString.contains("code=") {
                    if let range = requestURLString.range(of: "=") {
                        let githubCode = requestURLString[range.upperBound...]
                        if let range = githubCode.range(of: "&state=") {
                            let githubCodeFinal = githubCode[..<range.lowerBound]
                            githubRequestForAccessToken(authCode: String(githubCodeFinal))

                            // Close GitHub Auth ViewController after getting Authorization Code
//                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
}
