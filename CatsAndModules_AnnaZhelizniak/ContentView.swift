//
//  ContentView.swift
//  Cats
//
//  Created by Anna on 21.05.2023.
//

import SwiftUI
import FirebaseCrashlytics

struct ContentView: View {
    @StateObject private var catsData = CatsData()
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    Button("Crash 1") {
                        Crashlytics.crashlytics().log("Error 1 was trigerred")
                        Crashlytics.crashlytics().setCustomValue(1, forKey: "trigerredError")
                        fatalError("Crash was triggered")
                    }
                    Button("Crash 2") {
                        Crashlytics.crashlytics().log("Error 2 was trigerred")
                        Crashlytics.crashlytics().setCustomValue(2, forKey: "trigerredError")
                        var s:String? = nil
                        let a = s!
                    }
                    Button("Crash 3") {
                        Crashlytics.crashlytics().log("Error 3 was trigerred")
                        Crashlytics.crashlytics().setCustomValue(3, forKey: "trigerredError")
                        print(catsData.cats[1000])
                    }
                    ForEach(catsData.cats,id: \.id){ currentCat in
                        NavigationLink {
                            CatsDetailsView(currentCat: currentCat)
                        } label: {
                            CatView(currentCat: currentCat)
                        }
                    }
                }
            }
        }
        .task {
            await catsData.getCats()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
