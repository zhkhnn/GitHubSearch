//
//  ZimranApp.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import SwiftUI
import OAuthSwift
@main
struct ZimranApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let oauthSwift = OAuth2Swift(
//            consumerKey: "1f5c31cbadf064c8dc39",
//            consumerSecret: "5ff87e573c01cf7226be4fa7b7f2ed009f53b927",
//            authorizeUrl: "https://github.com/login/oauth/authorize",
//            accessTokenUrl: "https://github.com/login/oauth/access_token",
//            responseType: "code"
//        )
//        OAuthSwiftManager.shared.oauthswift = oauthSwift
//
//        return true
//    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    var oauthSwift: OAuth2Swift!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        oauthSwift = OAuth2Swift(
            consumerKey: "1f5c31cbadf064c8dc39",
            consumerSecret: "5ff87e573c01cf7226be4fa7b7f2ed009f53b927",
            authorizeUrl: "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType: "code"
        )

        return true
    }
}

