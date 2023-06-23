//
//  CatView.swift
//  Cats
//
//  Created by Anna on 21.05.2023.
//

import SwiftUI
import Networking
import Firebase
import SDWebImage
import SDWebImageSwiftUI

struct CatView: View {
    let currentCat:Cat
    @State private var trace: Trace? = nil
    var body: some View {
        VStack(alignment: .center){
            WebImage(url: URL(string: currentCat.url))
                .resizable()
                .onSuccess { _, _, _ in
                    self.trace?.stop()
                }
                .onFailure { _ in
                    self.trace?.stop()
                }
                .scaledToFit()
                .frame(width: 300)
                .onAppear {
                    self.trace = Performance.startTrace(name: "get_cat_image")
                }
            

            Text(currentCat.name)
                    .font(.title)
                    .foregroundColor(.black)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              alignment: .center
            )
        .padding()
        .padding(.top, 20)
        
        .background {
            ZStack(alignment: .top) {
                Rectangle()
                    .opacity(0.3)
                Rectangle()
                    .frame(maxHeight: 20)
            }
            .foregroundColor(.gray)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        
    }

}
