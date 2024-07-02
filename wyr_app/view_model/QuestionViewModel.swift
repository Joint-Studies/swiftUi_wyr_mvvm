import Foundation
import Alamofire
import FirebaseRemoteConfig

class QuestionViewModel :ObservableObject {
    @Published var question: Question?
    
    @RemoteConfigProperty(key: "base_url", fallback: "url") var urlBase: String
    @RemoteConfigProperty(key: "x_rapidapi_key", fallback: "key") var keyAPi: String
    
    func fetchQuestion()  {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": keyAPi,
            "x-rapidapi-host": "would-you-rather.p.rapidapi.com"
        ]
        
        let url = "\(urlBase)/random"
        
        AF.request(url, headers: headers).validate()
            .responseDecodable(of: [Question].self){response in
                switch response.result{
                case .success(let questionResponse):
                    DispatchQueue.main.async {
                        self.question = questionResponse.first
                    }
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                }
            }
        
    }
}

