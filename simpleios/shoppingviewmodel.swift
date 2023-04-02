import Combine
import SwiftUI

class ShoppingViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [CartItem] = []
    @Published var errorMessage: APIError?

    var cancellables = Set<AnyCancellable>()

    struct APIError: Identifiable {
        let id = UUID()
        let message: String
    }

    func fetchProducts() {
        let url = URL(string: "https://dummyjson.com/products")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [String: [Product]].self, decoder: JSONDecoder())
            .map { $0["products"] ?? [] }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = APIError(message: error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { self.products = $0 })
            .store(in: &cancellables)
    }


    func addToCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(product: product, quantity: 1))
        }
    }
}
