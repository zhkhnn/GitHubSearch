//
//  RepositoryRowView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 08.11.2023.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    @EnvironmentObject var history: HistoryModel


    var body: some View {
        VStack{
            HStack{
                Text(repository.name)
                    .bold()
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                Image(systemName: "star")
                    .font(.system(size: 14.0))
                Text("\(repository.stargazers_count)")
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                
                Spacer(minLength: 16.0)
                Image(systemName: "arrow.branch")
                    .font(.system(size: 14.0))
                Text("\(repository.forks_count)")
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                Image(systemName: history.contains(repository) ? "heart.fill" : "plus")
            }
        }
        .padding(10)
        .background(Color.clear)
        .cornerRadius(10)
        
    }
}

