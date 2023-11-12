//
//  ZimranApp.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import SwiftUI
import OAuthSwift
struct ZimranApp: App {
    var body: some Scene {
        WindowGroup {
            GithubLoginView()
        }
    }

}
//func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//    if url.scheme == "Zimran" {
//        OAuthSwift.handle(url: url)
//    }
//    return true
//}
//
