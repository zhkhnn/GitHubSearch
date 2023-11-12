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
    var body: some Scene {
        WindowGroup {
            GithubLoginView()
        }
    }

}

