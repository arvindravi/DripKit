import Foundation

public protocol DripKitType: AnyObject {
    func fetchWinterOutfits(_ page: Int, result: @escaping DripKit.WinterOutfitsResult)
}

public class DripKit: NSObject, DripKitType {
    
    // MARK: - Properties -
    
    // MARK: - Public -
    
    public static let shared: DripKitType = DripKit(session: .shared)
    
    // MARK: - Private -
    
    private let session: URLSession
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Custom Types -
    
    public typealias WinterOutfitsResult = (Result<WinterOutfitsRawResponse, Error>) -> Void
    
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
    
    public func fetchWinterOutfits(_ page: Int = 1, result: @escaping WinterOutfitsResult) {
        session.dataTask(with: Endpoint.winterOutfits(page: page).url) { data, response, error in
            guard let data = data else {
                self.finish { result(.failure(.invalidResponse)) }
                return
            }

            self.handleData(data: data, result: result)
        }.resume()
    }
        
    // MARK: - Private -
    
    private func handleData(data: Data?, result: @escaping WinterOutfitsResult) {
        guard let data = data else {
            finish { result(.failure(.failedToDecodeData)) }
            return
        }
        
        guard let decoded = try? decoder.decode(WinterOutfitsRawResponse.self, from: data) else {
            finish { result(.failure(.failedToDecodeData)) }
            return
        }
        
        finish { result(.success(decoded)) }
    }
    
    private func finish(callback: @escaping () -> ()) {
        DispatchQueue.main.async {
            callback()
        }
    }
}

