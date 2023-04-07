import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.Cart?.CartItems ?? []) { product in
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
                        .padding(.bottom, 10)
                    }

                }
            }
            .navigationTitle("Shopping Cart")
        }
    }
}
