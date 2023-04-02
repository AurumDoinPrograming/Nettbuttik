import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.cart.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.cart[index].product.title)
                            Text("\(viewModel.cart[index].product.price, specifier: "%.2f")")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("x\(viewModel.cart[index].quantity)")
                    }
                }
            }
            .navigationTitle("Shopping Cart")
        }
    }
}
