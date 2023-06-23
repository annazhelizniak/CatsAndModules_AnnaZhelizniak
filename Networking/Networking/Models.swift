//
//  Models.swift
//  Networking
//
//  Created by Anna on 21.05.2023.
//

import Foundation

private let names = ["Whiskers", "Bella", "Charlie", "Luna", "Lucy", "Max", "Oliver", "Molly", "Milo", "Tigger", "Simba", "Daisy", "Chloe", "Oscar", "Jasper"]


public struct Cats:Codable{
    let id:String
    let url:String
}
public struct Cat {
    public let id:String
    public let url:String
    public let name:String
    public init(id:String, url: String) {
        self.id = id
        self.url = url
        self.name = names[Int.random(in: 0..<names.count)]
    }
}
