//
//  CatsDetailsView.swift
//  Cats
//
//  Created by Anna on 21.05.2023.
//

import SwiftUI
import Networking
import Firebase
import SDWebImageSwiftUI

struct CatsDetailsView: View {
    let currentCat: Cat
    @State private var trace: Trace? = nil
    var body: some View {
        WebImage(url: URL(string: currentCat.url))
            .resizable()
            .onSuccess { _, _, _ in
                self.trace?.stop()
            }
            .onFailure { _ in
                self.trace?.stop()
            }
            .scaledToFit()
            .onAppear {
                self.trace = Performance.startTrace(name: "get_detailed_cat_image")
                Crashlytics.crashlytics().log("Selected cat: \(currentCat.id)")
                Crashlytics.crashlytics().setCustomValue(currentCat.name, forKey: "selectedCat")
                          
            }
    }
}

