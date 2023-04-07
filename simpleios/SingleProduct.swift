import SwiftUI
import Foundation

struct SingleProduct: View {
    
    var product: Product
    var body: some View {
        VStack {
            AsyncImage(url: product.thumbnail, content: { image in
                image.resizable()
            }, placeholder: {
                ProgressView()
            })
                .frame(width: 350, height: 200)
            VStack(alignment: .leading) {
                Text(product.title ?? "")
                Text("\(product.price ?? 0, specifier: "%.2f")")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
