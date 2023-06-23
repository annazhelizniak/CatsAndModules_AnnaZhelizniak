//
//  Networking.swift
//  Networking
//
//  Created by Anna on 21.05.2023.
//

import Foundation

public class Networking {
    
    private let url_cat = URL(string: "https://api.thecatapi.com/v1/images/search?limit=100&api_key=live_a4jcz3KMIunHXMf9qlzMoc1bM7sYXaEq0dpvKHcj0gugiryxRJRAUxjiTlARNhi7")!

    private let url_dog = URL(string: "https://api.thedogapi.com/v1/images/search?limit=100&api_key=live_a4jcz3KMIunHXMf9qlzMoc1bM7sYXaEq0dpvKHcj0gugiryxRJRAUxjiTlARNhi7")!
    
    public init() {}
    
    public func getCats() async throws -> [Cat] {
        var cats:[Cat] = []
        var url:URL
        if getDataSource() == "CATS"{
            url = url_cat
        } else {
            url = url_dog
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let parsed = try JSONDecoder().decode([Cats].self, from: data)
        
        for cat in parsed {
            cats.append(Cat(id: cat.id, url: cat.url))
        }
        return cats
    }
    
    private func getDataSource() -> String {
        let info = Bundle.main.infoDictionary
        return (info?["dataSource"] as! String)
    }
}
