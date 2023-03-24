//
//  ContentView.swift
//  NettbutikkApp
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
}

struct ProductMeta: Codable {
    var products: [Product]
    
}

class Api {
    func getProducts(completion: @escaping ([Product]) -> ()) {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let products = try JSONDecoder().decode(ProductMeta.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(products.products)
                }
            }
            catch {
                print(error)
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
            .navigationBarTitle("HOME")
            .onAppear {
                Api().getProducts { products in
                    self.products = products
                }
            }
            Form {
                Section {
                    Text("Handlekurv")
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
            
            Button(action: {
                
            }) {
                Image(systemName: "cart")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

        }
        .padding()
    }
}

struct HomePage: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Products", systemImage: "list.dash")
                }

            ProductView(product: Product(id: 1, title: "title", price: 100, description: "beskrivelse", category: "kategori"))
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            ProductView(product: Product(id: 2, title: "Bruker 1", price: 0, description: "Dette er din bruker", category: "kategori"))
                .tabItem {
                    Label("Users", systemImage: "multiply")
                }
        }
    }
}