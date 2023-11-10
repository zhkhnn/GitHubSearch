//
//  RepositoryDetailView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 06.11.2023.
//

import SwiftUI

struct RepositoryDetailView: View {
    @StateObject private var viewModel = UserViewModel()
    let repository: Repository
    let historyModel: HistoryModel
    @Binding var isViewed: Bool
    var body: some View {
        NavigationView{
            VStack{
                Group{
                    Text("Repository name: \(repository.name)")
                    Text("Repository date: \(formatDate(repository.created_at))")
                    Text("Repository stars: \(repository.stargazers_count)")
                    Text("Repository forks: \(repository.forks_count)")
                }
                .padding(10)
                
                Spacer()
                
                NavigationLink(destination: RepositoryListView(viewModel: viewModel, repo: repository.owner, history: historyModel)) {
                    Text(repository.owner.login)
                        .font(Font.headline.weight(.light))
                        .foregroundColor(Color.black)
                }
                Spacer()
                Button(action: {
                    self.isViewed = true
                    print("toggled")
                    historyModel.addToHistory(repository)
                }){
                    Image(systemName: self.isViewed == true ? "heart.fill" : "plus")
                    
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: repository.owner.avatar_url))
                    .frame(width: 300, height: 300)
                                .background(Color.gray)
                                .clipShape(Circle())
                
            }
            
        }
        
    }
    
    
    func formatDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    
}
