//
//  APIService.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import Foundation
import Combine

class APIService {
    @Published var searchResults: SearchResult = SearchResult()

    func search(for query: String){
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(SearchResult.self, from: data)
                    DispatchQueue.main.async {
                        self.searchResults = results
                        self.searchResults.total_count = results.total_count
                    }
                    
                } catch {
                    print(error)
                }
            }
            
        }
        
        task.resume()
    }
}
