//
//  DogsListView.swift
//  CatsAndModules
//
//  Created by Kyrylo Derkach on 13.06.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct DogsListView: View {
    @StateObject private var viewModel = AnimalsListViewModel()
    
    @State private var isDataCollectionEnabled = UserDefaults.standard.bool(forKey: "DataCollectionEnabled")
    @State private var launchedBefore = UserDefaults.standard.bool(forKey: "LaunchedBefore")
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button("Crash app") {
                fatalError("Crash button pressed")
                
                //let crusherValue = 0
                //division(number: crusherValue)
                
                //let emptyArray: [Int] = []
                //let outOfBoundIndex = 5
                //let element = getByIndex(from: emptyArray, index: outOfBoundIndex)
            }
            NavigationView {
                List(viewModel.animals) { dog in
                    NavigationLink(destination: DogDetailView(dog: dog)) {
                        HStack {
                            AsyncImage(url: URL(string: dog.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: 75, height: 75)
                            .cornerRadius(20)
                            Text("Dog \(dog.id)")
                        }
                    }
                }
                .background(Color.purple.opacity(0.5))
                .navigationTitle("Dogs")
                
            }
            .onAppear {
                viewModel.fetchDogs(amount: 10)
                if !launchedBefore {
                    showAlert = true
                } else if isDataCollectionEnabled {
                    Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                title: Text("Data Collection"),
                message: Text("Do you agree for data collection for app further improvement?"),
                primaryButton: .default(Text("Accept"), action: {
                    isDataCollectionEnabled = true
                    UserDefaults.standard.set(true, forKey: "DataCollectionEnabled")
                    Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                }),
                secondaryButton: .cancel(Text("Decline"), action: {
                    isDataCollectionEnabled = false
                    UserDefaults.standard.set(false, forKey: "DataCollectionEnabled")
                }))
            }
            .onDisappear {
                if !launchedBefore {
                    launchedBefore = true
                    UserDefaults.standard.set(true, forKey: "LaunchedBefore")
                }
            }
        }
    }
    
    func division(number: Int) {
        let value = 1/number
    }
    func getByIndex(from array: [Int], index: Int) -> Int {
        return array[index]
    }
}

struct DogList_Previews: PreviewProvider {
    static var previews: some View {
        DogsListView()
    }
}
