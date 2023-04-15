import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        
        // TODO
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else { return }
        
        network.performGet(url: url) { data in
            completion(parseJson(from: data))
        }
        
    }
    
    func parseJson(from data: Data?) -> [Repository]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedJson = try decoder.decode([Repository].self, from: data ?? Data())
            return decodedJson
        } catch {
            return nil
        }
        
    }
}


