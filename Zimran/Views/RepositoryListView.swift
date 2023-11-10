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
            VStack(alignment: .leading, spacing: 5){
                ScrollView{
                    ForEach(viewModel.repositories){ repository in
                        NavigationLink(destination: HistoryView(historyModel: history)){
                            Text("\(repository.name)")
                                .bold()
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                                .lineLimit(1)
                            Spacer(minLength: 14.0)
                            Image(systemName: "star")
                                .font(.system(size: 14.0))
                            Text("\(repository.stargazers_count)")
                                .foregroundColor(.gray)
                                .lineLimit(nil)
                        }
                        .padding(10)
                        .background(Color.clear)
                        .cornerRadius(10)
                        
                    }
                }
                
            }
            .task {
                viewModel.getRepositories(for: repo.login)
            }
            .navigationTitle("\(repo.login)")
            .navigationBarBackButtonHidden(true)
        }
        
       
    }
}

