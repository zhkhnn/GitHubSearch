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
    @EnvironmentObject var history: HistoryModel
    private let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationView{
            VStack{
                Section(header: Text("Repository information").font(.system(size: 20))
                    .fontWeight(.bold)){
                    Group{
                        Text("Repository name: \(repository.name)")
                        Text("Repository date: \(formatDate(repository.created_at))")
                        Text("Repository stars: \(repository.stargazers_count)")
                        Text("Repository forks: \(repository.forks_count)")
                    }
                    .padding(10)
                    
                }
                
                
                Spacer()
                Section(header: Text("Owner information").font(.system(size: 20))
                    .fontWeight(.bold)){
                    HStack{
                        AsyncImage(url: URL(string: repository.owner.avatar_url))
                            .frame(width: 200,
                                                       height: 200,
                                                       alignment: .center)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                        NavigationLink(destination: RepositoryListView(viewModel: viewModel, repo: repository.owner, history: historyModel).navigationBarBackButtonHidden(true)) {
                            Text(repository.owner.login)
                                .font(Font.headline.weight(.light))
                                .foregroundColor(Color.black)
                        }
                    }
                }
                
                
                
                Spacer()
                Button(action: {
                    historyModel.addToHistory(repository)
                    historyModel.toggleLikedStatus(for: repository)
                }){
                    Image(systemName: historyModel.isRepositoryLiked(repository: repository) ? "heart.fill" : "plus")
                    
                }
                
                Spacer()
                
                
                
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
