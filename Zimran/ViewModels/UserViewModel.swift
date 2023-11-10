//
//  UserViewModel.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import Foundation
import Combine
class UserViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    func getRepositories(for username: String){
        let url = URL(string: "https://api.github.com/users/\(username)/repos")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode([Repository].self, from: data)
                    DispatchQueue.main.async {
                        self.repositories = results
                    }
                } catch {
                    print(error)
                }
            }
            
        }
        
        task.resume()
    }
}
