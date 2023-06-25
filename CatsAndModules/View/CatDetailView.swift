//
//  CatDetailView.swift
//  CatsAndModules
//
//  Created by Kyrylo Derkach on 30.05.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct CatDetailView: View {
    let cat: Animal
    
    var body: some View {
        ZStack {
            Color.purple.opacity(0.5)
            VStack {
                AsyncImage(url: URL(string: cat.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                Text("Cat \(cat.id)")
            }
            .scaledToFit()
            .background(Color.purple.opacity(0.5))
        }
        .background(
            NavigationLinkHelper(animal:cat, action: logNavigation))
    }
    
    func logNavigation(cat: Animal) {
        print()
        print("log navigation func called")
        print()
        Crashlytics.crashlytics().log("Cat \(cat.id) has been selected")
        Crashlytics.crashlytics().setCustomValue(cat.id, forKey: "SelectedCatID")
        Crashlytics.crashlytics().sendUnsentReports()
    }
}

//struct CatDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatDetailView()
//    }
//}
