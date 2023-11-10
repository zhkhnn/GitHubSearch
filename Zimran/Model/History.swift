//
//  History.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 08.11.2023.
//

import Foundation
import Combine

class HistoryModel: ObservableObject {
    @Published var history: [Repository] = []

    func addToHistory(_ repository: Repository) {
        history.append(repository)
    }
}
