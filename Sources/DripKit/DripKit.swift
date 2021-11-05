import Foundation

public protocol DripKitType: AnyObject {
    func fetchWinterOutfits(_ page: Int) async throws -> DripKit.WinterOutfitsRawResponse
}

public class DripKit: NSObject, DripKitType {
    
    // MARK: - Properties -
    
    // MARK: - Public -
    
    public static let shared: DripKitType = DripKit(session: .shared)
    
    // MARK: - Private -
    
    private let session: URLSession
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Custom Types -
    
    public enum Error: LocalizedError {
        case invalidResponse
        case failedToDecodeData
        
        public var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Error Fetching Data: Invalid Response."
            case .failedToDecodeData: return "Error Fetching Data: Failed to decode data."
            }
        }
    }
    
    private enum Endpoint {
        static let baseURL = URL(string: "https://www.thread.com/api/winter-outfits/98/")!
        
        case winterOutfits(page: Int)
        
        var url: URL {
            switch self {
            case .winterOutfits(let page): return Endpoint.baseURL.appendingPathComponent("\(page)")
            }
        }
    }
    
    // MARK: - Initialiser
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Interface -
    
    // MARK: - Public -
    
    public func fetchWinterOutfits(_ page: Int = 1) async throws -> WinterOutfitsRawResponse {
        let urlRequest = URLRequest(url: Endpoint.winterOutfits(page: page).url)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw Error.invalidResponse
        }
        
        guard let result = try? decoder.decode(WinterOutfitsRawResponse.self, from: data) else {
            throw Error.failedToDecodeData
        }
        
        return result
    }
}

