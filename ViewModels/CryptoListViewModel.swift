import Foundation

@MainActor
class CryptoListViewModel: ObservableObject {
    @Published var cryptocurrencies: [Cryptocurrency] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchCryptocurrencies() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                cryptocurrencies = try await APIService.shared.fetchCryptocurrencies()
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
} 