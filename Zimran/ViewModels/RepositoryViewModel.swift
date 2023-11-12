//
//  RepositoryViewModel.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import Foundation

class RepositoryViewModel: ObservableObject {
    enum sortOptions{
        case date, stars, forks
    }
    @Published var searchResults: SearchResult = SearchResult()
    @Published var filteredRepo: [Repository] = []
    @Published var isLoading: Bool = false
    
    private var repos: [Repository] {
        filteredRepo.isEmpty ? searchResults.items! : filteredRepo
    }
    
    
    @MainActor
    func search(for query: String){
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        isLoading = true
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(SearchResult.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.searchResults = results
                        self.searchResults.total_count = results.total_count
                        print("decoded")
                    }
                    
                } catch {
                    print(error)
                }
            }
            
        }
        
        task.resume()
    }
    
    func sortResults(by option: sortOptions) {
        var sortedRepo = searchResults.items
        switch option {
        case .date:
            sortedRepo?.sort{lhs, rhs in
                lhs.created_at < rhs.created_at
            }
        case .stars:
            sortedRepo?.sort { $0.stargazers_count < $1.stargazers_count }
        case .forks:
            sortedRepo?.sort{lhs, rhs in
                lhs.forks_count < rhs.forks_count
            }
        }
        if filteredRepo.isEmpty {
            searchResults.items = sortedRepo
        }else{
            filteredRepo = sortedRepo!
        }
    }
    func hasReachedEnd(of repo: Repository) -> Bool{
        if let lastIndex = searchResults.items?.lastIndex(where: { $0.id == repo.id }) {
                searchResults.items?[lastIndex].id = repo.id
                return true
            }
            return false
    }
    @MainActor func loadNextData(withQuery query: String) {
        guard !isLoading else {
            return
        }

        guard let totalCount = searchResults.total_count,
              let currentCount = searchResults.items?.count,
              currentCount < totalCount else {
            return
        }

        let nextPage = (currentCount / 30) + 1
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)&page=\(nextPage)")!

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
            isLoading = true

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let results = try decoder.decode(SearchResult.self, from: data)
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.searchResults.items?.append(contentsOf: results.items ?? [])
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
    




