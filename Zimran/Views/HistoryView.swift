//
//  HistoryView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 08.11.2023.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var historyModel: HistoryModel

    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(historyModel.history.suffix(20).reversed()) { repo in
                        Text("\(repo.owner.login)")
                            .padding(10)
                    }
                    .onDelete(perform: delete)
                    .listStyle(GroupedListStyle())
                    .listRowInsets(EdgeInsets())
                    .onAppear {
                        historyModel.load()
                    }
                }
            }
            
            
            .navigationTitle("Repository History")
            
            
            .navigationBarItems(trailing: EditButton().foregroundColor(.black))
            .background(Color(red: 191/255, green: 181/255, blue: 158/255))
        }
        
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let removedRepo = historyModel.history.remove(at: index)
            historyModel.removeFromHistory(removedRepo)
        }
    }
}

