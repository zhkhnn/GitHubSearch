//
//  MainView.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 12.11.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = RepositoryViewModel()
    @State private var searchText = ""
    @State private var isListing = false
    @State var nextIndex = 1
    @StateObject private var historyModel = HistoryModel()
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
                        viewModel.isLoading = true
                    }) {
                        Text("Search")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(5)
                    .background(Color(red: 133/255, green: 135/255, blue: 134/255))
                    .buttonStyle(.bordered)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                ScrollView{
                    Text(viewModel.searchResults.total_count == 0 ? "Please, check for spelling of your repository name" : "Founded \(viewModel.searchResults.total_count ?? 0) repositories")
                    ForEach(Array(viewModel.searchResults.items ?? []), id: \.id) { repository in
                        NavigationLink(destination: RepositoryDetailView(repository: repository, historyModel: historyModel)){
                            
                            RepositoryRowView(repository: repository)
                        }
                        .onAppear{
                            if viewModel.hasReachedEnd(of: repository){
                                viewModel.loadNextData(withQuery: searchText)
                            }
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
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: GithubLoginView()) {
                        Text("LogOut")
                            .foregroundColor(.black)
                    }
                }
            }
            .accentColor(.black)

            .background(Color(red: 180/255, green: 173/255, blue: 163/255))
            
        }
        .environmentObject(historyModel)
        
    }
}

