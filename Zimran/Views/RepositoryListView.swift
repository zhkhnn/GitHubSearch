//
//  RepositoryListView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 06.11.2023.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: UserViewModel
    let repo: User
    let history: HistoryModel
    var body: some View {
        NavigationView{
                ScrollView{
                    ForEach(viewModel.repositories){ repository in
                        NavigationLink(destination: HistoryView(historyModel: history).navigationBarHidden(true)){
                            Text("\(repository.name)")
                                .bold()
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                                .lineLimit(1)
                            Spacer(minLength: 14.0)
                            Image(systemName: "star")
                                .font(.system(size: 14.0))
                                .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                            Text("\(repository.stargazers_count)")
                                .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                                .lineLimit(nil)
                            Image(systemName: history.contains(repository) ? "heart.fill" : "")
                                .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                        }
                        .padding(10)
                        .background(Color.clear)
                        .cornerRadius(10)
                        
                    }
                
                
            }
            .task {
                viewModel.getRepositories(for: repo.login)
            }
            .navigationTitle("\(repo.login)")
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 202/255, green: 183/255, blue: 162/255))
        }
        
       
    }
}

