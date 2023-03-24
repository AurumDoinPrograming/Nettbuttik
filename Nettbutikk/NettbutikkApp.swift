//
//  NettbutikkApp.swift
//  Nettbutikk
//
//  Created by Peder Nikolay Spongsveen on 16/03/2023.
//

import SwiftUI

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}

class Api {
    func getProducts(completion: @escaping ([Product]) -> ()) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let products = try! JSONDecoder().decode([Product].self, from: data!)
            
            DispatchQueue.main.async {
                completion(products)
            }
        }
        .resume()
    }
}

struct ContentView: View {
    @State var products: [Product] = []
    
    var body: some View {
        NavigationView {
            List(products) { product in
                NavigationLink(destination: ProductView(product: product)) {
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.headline)
                        Text("$\(product.price)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Products")
            .onAppear {
                Api().getProducts { products in
                    self.products = products
                }
            }
        }
    }
}

struct ProductView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.title)
                .font(.title)
            Text("$\(product.price)")
                .font(.subheadline)
            Text(product.description)
                .font(.body)
        }
        .padding()
    }
}
