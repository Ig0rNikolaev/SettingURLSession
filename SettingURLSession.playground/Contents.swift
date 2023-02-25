import Foundation

class CreatureURL {

    func buildNbaURL() -> URL? {
        let scheme = "https"
        let host = "any-api.com"
        let path = "/nba_com/nba_com/docs/API_Description"

        var components: URLComponents = {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            return components
        }()
        return components.url
    }
}

class CreatureURLRequest {

    func getData(urlRequest: URL?) {
        guard let url = urlRequest else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {



            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                let dataAsString = String(data: data, encoding: .utf8)


                
            }
        }.resume()
    }
}
