import Foundation

@MainActor
class CryptoDetailViewModel: ObservableObject {
    let cryptocurrency: Cryptocurrency
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptocurrency = cryptocurrency
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: cryptocurrency.currentPrice)) ?? "$0.00"
    }
    
    var formattedMarketCap: String {
        guard let marketCap = cryptocurrency.marketCap else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: marketCap)) ?? "N/A"
    }
    
    var formattedPriceChange: String {
        guard let change = cryptocurrency.priceChangePercentage24h else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: change / 100)) ?? "N/A"
    }
    
    var isPriceChangePositive: Bool {
        guard let change = cryptocurrency.priceChangePercentage24h else { return false }
        return change >= 0
    }
} 