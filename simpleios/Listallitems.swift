import SwiftUI

struct ListAllItemsView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.products, id: \.self) { product in
                    NavigationLink(destination: SingleProduct(product: product)) {
                        HStack {
                            AsyncImage(url: product.thumbnail, content: { image in
                                image.resizable()
                            }, placeholder: {
                                ProgressView()
                            })
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(product.title ?? "")
                                Text("\(product.price ?? 0, specifier: "%.2f")")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("All Items")
            .alert(item: $viewModel.errorMessage) { apiError in
                Alert(title: Text("Error"), message: Text(apiError.message), dismissButton: .default(Text("OK")))
            }
            .task {
                await viewModel.fetchProducts()
            }
        }
    }
}
