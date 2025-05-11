import SwiftUI

struct CryptoListView: View {
    @StateObject private var viewModel = CryptoListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error")
                            .font(.headline)
                        Text(errorMessage)
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetchCryptocurrencies()
                        }
                        .padding()
                    }
                } else {
                    List(viewModel.cryptocurrencies) { crypto in
                        NavigationLink(destination: CryptoDetailView(cryptocurrency: crypto)) {
                            CryptoRowView(cryptocurrency: crypto)
                        }
                    }
                    .refreshable {
                        viewModel.fetchCryptocurrencies()
                    }
                }
            }
            .navigationTitle("CryptoTrack")
        }
        .onAppear {
            viewModel.fetchCryptocurrencies()
        }
    }
}

struct CryptoRowView: View {
    let cryptocurrency: Cryptocurrency
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: cryptocurrency.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(width: 40, height: 40)
            .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(cryptocurrency.name)
                    .font(.headline)
                Text(cryptocurrency.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(formatPrice(cryptocurrency.currentPrice))
                    .font(.headline)
                if let change = cryptocurrency.priceChangePercentage24h {
                    Text(formatPercentage(change))
                        .font(.subheadline)
                        .foregroundColor(change >= 0 ? .green : .red)
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: price)) ?? "$0.00"
    }
    
    private func formatPercentage(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value / 100)) ?? "0%"
    }
} 