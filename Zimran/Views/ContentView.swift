//
//  ContentView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RepositoryViewModel()
    @State private var searchText = ""
    @State private var isListing = false
    @State var isViewed = false;
    @ObservedObject private var historyModel = HistoryModel()
    @State private var viewedRepositoryID: Int? = nil
    @State private var sortOption: RepositoryViewModel.sortOptions = .stars
    var body: some View {
        NavigationView{
            VStack {
                Picker("Sort By", selection: $sortOption) {
                    Text("Date").tag(RepositoryViewModel.sortOptions.date)
                    Text("Star").tag(RepositoryViewModel.sortOptions.stars)
                    Text("Fork").tag(RepositoryViewModel.sortOptions.forks)
                }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: sortOption, perform: viewModel.sortResults)
                HStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing, 8)
                        TextField("Search repositories", text: $searchText)
                            
                    }
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    
                    
                    
                    
                    Button(action: {
                        viewModel.search(for: searchText)
                    }) {
                        Text("Search")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(5)
                    .background(.gray)
                    .buttonStyle(.bordered)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                ScrollView{
                    Text("Founded \(viewModel.searchResults.total_count ?? 0) repositories")
                    ForEach(Array(viewModel.searchResults.items ?? []), id: \.id) { repository in
                        NavigationLink(destination: RepositoryDetailView(repository: repository, historyModel: historyModel, isViewed: $isViewed)){
                            RepositoryRowView(repository: repository)
                        }
                    }
                }
                .padding(5)
                
            }
            .navigationTitle("GitHub Repo Search")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HistoryView(historyModel: historyModel)) {
                        Text("History")
                    }
                }
            }
            if isListing{
                Button(action: {
                    viewModel.search(for: searchText)
                }) {
                    Text("Next")
                }
            }
            
        }
        
    }
}

    
        
    

