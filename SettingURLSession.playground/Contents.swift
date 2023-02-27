import Foundation
import CryptoKit

class CreatureURL {

    func buildURL(scheme: String, host: String, path: String) -> URL? {

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        return components.url
    }
}

class CreatureURLMarvel: CreatureURL {

        override func buildURL(scheme: String, host: String, path: String) -> URL? {

            let publicKey = "8ff288aa4d9bd9b25d051aea9585e041"
            let privateKey = "745eeeff855e804c98b080fd6570b1b2b8553550"
            let ts = Date().timeIntervalSince1970.description
            let hashString = ts + privateKey + publicKey
            let hash = String.md5(hashString)
            let queryItem = [
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "apikey", value: publicKey),
                URLQueryItem(name: "hash", value: hash)
            ]

            var url = super.buildURL(scheme: scheme, host: host, path: path)
            url?.append(queryItems: queryItem)
            return url
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
                    print("Информационный код: \(response.statusCode)")
                case 200...299:
                    guard let data = data else { return }
                    let dataAsString = String(data: data, encoding: .utf8)
                    print("Код ответа от сервера:\n \(response)\n Данные, пришедшие с сервера:\n \(String(describing: dataAsString))")
                case 300...399:
                    print("Сообщение о перенаправлении: \(response.statusCode)")
                case 400...499:
                    print("Клиентская ошибка: \(response.statusCode)")
                case 500...599:
                    print("Серверная ошибка: \(response.statusCode)")
                default:
                    break
                }
            }.resume()
        }
    }


let requestURL = CreatureURLRequest()

let urlNba = CreatureURL()
let nba = urlNba.buildURL(scheme: "https", host: "any-api.com", path: "/nba_com/nba_com/docs/API_Description")
requestURL.getData(urlRequest: nba)

let urlMarvel = CreatureURLMarvel()
let marvel = urlMarvel.buildURL(scheme: "https", host: "gateway.marvel.com", path: "/v1/public/comics")
requestURL.getData(urlRequest: marvel)

extension String {
   static func md5(_ source: String) -> String {
        return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}

