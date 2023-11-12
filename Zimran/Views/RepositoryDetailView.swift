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
            VStack(){
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
                        AsyncImage(url: URL(string: repository.owner.avatar_url)){
                            image in
                            image
                                        .resizable()
                                        .scaledToFill()
                        }placeholder: {
                            ProgressView()
                        }
                            .frame(width: 150,
                                                       height: 150,
                                                       alignment: .center)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        Spacer()
                        NavigationLink(destination: RepositoryListView(viewModel: viewModel, repo: repository.owner, history: historyModel).navigationBarBackButtonHidden(true)) {
                            Text(repository.owner.login)
                                .font(.system(size: 24))
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                        
                    }
                    .padding(.horizontal, 8)
                }
                Button(action: {
                    if historyModel.contains(repository){
                        historyModel.removeFromHistory(repository)
                    }
                    else{
                        historyModel.addToHistory(repository)
                        historyModel.toggleLikedStatus(for: repository)
                    }
                    
                }){
                    Image(systemName: historyModel.isRepositoryLiked(repository: repository) ? "heart.fill" : "plus")
                        .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                    
                }
                .frame(width: 200, height: 50)
                .background(Color(red: 196/255, green: 177/255, blue: 174/255))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                Spacer()
            }
            .background(Color(red: 196/255, green: 177/255, blue: 174/255))
        }
        
        
    }
    
    
    func formatDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    
}
