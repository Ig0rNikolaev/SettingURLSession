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

class CreatureMarvelURL: CreatureURL {
    override func buildNbaURL() -> URL? {
        <#code#>
    }
}

final class CreatureURLRequest {

    func getData(urlRequest: URL?) {
        guard let url = urlRequest else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Ошибка при запросе: \(String(describing: error?.localizedDescription))")
            }

            guard let response = response as? HTTPURLResponse else { return }

            switch response.statusCode {
            case 100...103:
                print("\(response.statusCode)")
            case 200...299:
                guard let data = data else { return }
                let dataAsString = String(data: data, encoding: .utf8)
                print("Код ответа от сервера:\n \(response)\n Данные, пришедшие с сервера:\n \(String(describing: dataAsString))")
            case 300...399:
                print("\(response.statusCode)")
            case 400...499:
                print("\(response.statusCode)")
            case 500...599:
                print("\(response.statusCode)")
            default:
                break
            }
        }.resume()
    }
}

var urlNba = CreatureURL()
var request = CreatureURLRequest()

request.getData(urlRequest: urlNba.buildNbaURL())




