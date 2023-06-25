//
//  DogDetailView.swift
//  CatsAndModules
//
//  Created by Kyrylo Derkach on 13.06.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct DogDetailView: View {
    let dog: Animal
    
    var body: some View {
        ZStack {
            Color.purple.opacity(0.5)
            VStack {
                AsyncImage(url: URL(string: dog.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                Text("Dog \(dog.id)")
            }
            .scaledToFit()
            .background(Color.purple.opacity(0.5))
        }
        .background(
            NavigationLinkHelper(animal:dog, action: logNavigation))
    }
    
    func logNavigation(dog: Animal) {
        print()
        print("log navigation func called")
        print()
        Crashlytics.crashlytics().log("Dog \(dog.id) has been selected")
        Crashlytics.crashlytics().setCustomValue(dog.id, forKey: "SelectedDogID")
        Crashlytics.crashlytics().sendUnsentReports()
    }
}
//
//struct DogDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DogDetailView()
//    }
//}
