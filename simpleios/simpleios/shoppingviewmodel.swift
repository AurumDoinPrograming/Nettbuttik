import Combine
import SwiftUI

class ShoppingViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var Cart: Cart? = nil
    @Published var errorMessage: APIError?

    var cancellables = Set<AnyCancellable>()

    struct APIError: Identifiable {
        let id = UUID()
        let message: String
    }

    func fetchProducts() async {
        do {
            products = try await getProducts(urlString: "https://dummyjson.com/products")
            Cart = try await getCarts(urlString: "https://dummyjson.com/carts/1")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getProducts(urlString: String) async throws -> [Product] {
            let url = URL(string: urlString)!
            let urlrequest = URLRequest(url: url)

            let (data, _) = try await URLSession.shared.data(for: urlrequest)
            let svar = try JSONDecoder().decode(ProductMeta.self, from: data)
            return svar.products
        }

   func getCarts(urlString: String) async throws -> Cart {
            let url = URL(string: urlString)!
            let urlrequest = URLRequest(url: url)

            let (data, _) = try await URLSession.shared.data(for: urlrequest)
            let svar = try JSONDecoder().decode(CartMeta.self, from: data)
            return svar.Carts[0]
        }
}


