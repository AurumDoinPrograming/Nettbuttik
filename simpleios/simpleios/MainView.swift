import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ShoppingViewModel()

    var body: some View {
        TabView {
            ListAllItemsView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("All Items")
                }

            ShoppingCartView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shopping Cart")
                }

            UserDataView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My Account")
                }
        }
        .task {
            await viewModel.fetchProducts()
        }
    }
}
