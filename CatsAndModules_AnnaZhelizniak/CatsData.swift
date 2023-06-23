//
//  CatsData.swift
//  Cats
//
//  Created by Anna on 21.05.2023.
//

import Foundation
import Networking
import Firebase

class CatsData: ObservableObject {
    @Published var cats = [Cat]()
    private var trace: Trace?
    
    func getCats() async {
        self.trace = Performance.startTrace(name: "get_list_of_cats")
        do {
            let networking = Networking()
            self.cats = try await networking.getCats()
            self.trace?.stop()
        } catch {
            print(error)
        }
    }
}




