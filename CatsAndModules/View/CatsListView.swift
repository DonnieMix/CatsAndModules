//
//  ContentView.swift
//  CatsAndModules
//
//  Created by Kyrylo Derkach on 26.05.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct CatsListView: View {
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
                List(viewModel.animals) { cat in
                    NavigationLink(destination: CatDetailView(cat: cat)) {
                        HStack {
                            AsyncImage(url: URL(string: cat.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: 75, height: 75)
                            .cornerRadius(20)
                            Text("Cat \(cat.id)")
                        }
                    }
                }
                .background(Color.purple.opacity(0.5))
                .navigationTitle("Cats")
                
            }
            .onAppear {
                viewModel.fetchCats(amount: 10)
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
public struct NavigationLinkHelper: View {
    let animal: Animal
    let action: (Animal) -> Void
    
    public var body: some View {
        Color.clear
            .onAppear {
                action(animal)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatsListView()
    }
}
