import SwiftUI

struct CryptoDetailView: View {
    @StateObject private var viewModel: CryptoDetailViewModel
    
    init(cryptocurrency: Cryptocurrency) {
        _viewModel = StateObject(wrappedValue: CryptoDetailViewModel(cryptocurrency: cryptocurrency))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    AsyncImage(url: URL(string: viewModel.cryptocurrency.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
                    
                    Text(viewModel.cryptocurrency.name)
                        .font(.title)
                        .bold()
                    
                    Text(viewModel.cryptocurrency.symbol.uppercased())
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Price Information
                VStack(spacing: 16) {
                    PriceInfoRow(title: "Current Price", value: viewModel.formattedPrice)
                    PriceInfoRow(title: "Market Cap", value: viewModel.formattedMarketCap)
                    PriceInfoRow(
                        title: "24h Change",
                        value: viewModel.formattedPriceChange,
                        valueColor: viewModel.isPriceChangePositive ? .green : .red
                    )
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                // Placeholder for future price chart
                VStack {
                    Text("Price Chart (Coming Soon)")
                        .font(.headline)
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .cornerRadius(12)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PriceInfoRow: View {
    let title: String
    let value: String
    var valueColor: Color = .primary
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .bold()
                .foregroundColor(valueColor)
        }
    }
} 