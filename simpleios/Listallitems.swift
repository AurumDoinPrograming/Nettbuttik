import SwiftUI

struct ListAllItemsView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                HStack {
                    AsyncImage(url: product.thumbnail, content: { image in
                        image.resizable()
                    }, placeholder: {
                        ProgressView()
                    })
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(product.title)
                        Text("\(product.price, specifier: "%.2f")")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.addToCart(product: product)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("All Items")
            .alert(item: $viewModel.errorMessage) { apiError in
                Alert(title: Text("Error"), message: Text(apiError.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
