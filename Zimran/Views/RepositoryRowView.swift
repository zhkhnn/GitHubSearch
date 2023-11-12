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
                    .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                Text("\(repository.stargazers_count)")
                    .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                    .lineLimit(nil)
                
                Spacer(minLength: 16.0)
                Image(systemName: "arrow.branch")
                    .font(.system(size: 14.0))
                    .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                Text("\(repository.forks_count)")
                    .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
                    .lineLimit(nil)
                Image(systemName: history.contains(repository) ? "heart.fill" : "plus")
                    .foregroundColor(Color(red: 75/255, green: 59/255, blue: 64/255))
            }
            .onAppear{
                history.load()
            }
        }
        .padding(10)
        .background(Color.clear)
        .cornerRadius(10)
        
    }
}

