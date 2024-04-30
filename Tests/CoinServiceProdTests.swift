import XCTest
@testable import CoinService

final class CoinServiceProdTests: XCTestCase {
    var service: CoinService!
    
    override  func setUp() {
        service = CoinService()
    }
    
    func testFetchCoins() throws {
        let expectation = expectation(description: "Able to fetch coins from server")
        Task {
            do {
                let coins = try await service.coins()
                expectation.fulfill()
            } catch {
                XCTFail("Got an error: \(error) - \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 5)
    }
}
