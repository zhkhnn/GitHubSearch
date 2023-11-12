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
            ContentView()
        }
    }

}
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        if url.host == "oauth-callback" {
            OAuthSwift.handle(url: url)
        }
}
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if url.scheme == "Zimran" {
        OAuthSwift.handle(url: url)
    }
    return true
}

