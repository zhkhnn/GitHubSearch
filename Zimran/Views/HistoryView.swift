//
//  HistoryView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 08.11.2023.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var historyModel: HistoryModel
    var body: some View {
        NavigationView {
                    List(historyModel.history) { repo in
                        Text("\(repo.name)")
                    }
                    .navigationTitle("Repository History")
                }
    }
}
