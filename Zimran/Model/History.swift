//
//  History.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 08.11.2023.
//

import Foundation

class HistoryModel: ObservableObject {
    
    @Published var history: [Repository] = []
    @Published var likedRepositories: Set<Int> = []
    
    init(){
        history = []
    }

    func addToHistory(_ repository: Repository) {
        history.append(repository)
        save()
        print("added")
    }
    func contains(_ repository: Repository) -> Bool {
            return history.contains { $0.id == repository.id }
        }
    func toggleLikedStatus(for repository: Repository) {
            if likedRepositories.contains(repository.id) {
                likedRepositories.remove(repository.id)
            } else {
                likedRepositories.insert(repository.id)
            }
        }
    func isRepositoryLiked(repository: Repository) -> Bool {
            return likedRepositories.contains(repository.id)
        }
    func save() {
            do {
                let data = try JSONEncoder().encode(history)
                UserDefaults.standard.set(data, forKey: "historyKey")
            } catch {
                print("Failed to save history: \(error.localizedDescription)")
            }
        }

        func load() {
            if let data = UserDefaults.standard.data(forKey: "historyKey") {
                do {
                    history = try JSONDecoder().decode([Repository].self, from: data)
                } catch {
                    print("Failed to load history: \(error.localizedDescription)")
                }
            }
        }
}
