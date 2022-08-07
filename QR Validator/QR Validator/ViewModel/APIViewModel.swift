//
//  APIViewModel.swift
//  QR Validator
//
//  Created by Luke Hendriks on 17/07/2022.
//

import Foundation

class APIViewModel {
    static var shared = APIViewModel()
    var latestAPIResponse: APIResponseModel? = nil
    var latestScannedURL: URL? = nil
    var latestError: CustomErrors? = nil
    
    var API_KEY: String = ""
            
    let client: Dictionary<String, Any> = [
        "clientId": "QR-Validator",
        "clientVersion": "1.0.0"
    ]

    let platformTypes = ["ANY_PLATFORM"]
    let threatEntryTypes = ["URL"]
    
    func checkURLSafety(urlToCheck: URL, completion: @escaping (_ result: Bool?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "secrets", ofType: "plist") {
            let secretsDict = NSDictionary(contentsOfFile: path)
            if let dict = secretsDict {
                API_KEY = dict["googleSafeBrowsingAPIKey"] as? String ?? ""
            }
        }
        
        if API_KEY == "" {
            self.latestError = CustomErrors.APIKeyError
            completion(nil, CustomErrors.APIKeyError)
            return
        }
                
        let API_URL = URL(string: "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=\(API_KEY)")
                
        let threatTypes = UserDefaults.standard.array(forKey: "selectedThreatTypes") as? [String] ?? ["THREAT_TYPE_UNSPECIFIED", "MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE", "POTENTIALLY_HARMFUL_APPLICATION"]
                
        let threatEntries = [["url":"\(urlToCheck)"]]
        
        let threatInfo: Dictionary<String, Any> = [
            "threatTypes": threatTypes,
            "platformTypes": platformTypes,
            "threatEntryTypes": threatEntryTypes,
            "threatEntries": threatEntries
        ]
        
        let params: Dictionary<String, Any> = [
            "client": client,
            "threatInfo": threatInfo
        ]
        
        let jsonParams = try? JSONSerialization.data(withJSONObject: params)
        
        let session = URLSession.shared
        var urlRequest = URLRequest(url: API_URL!)
        urlRequest.httpBody = jsonParams
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
                        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                self.latestError = CustomErrors.unknownError
                completion(nil, CustomErrors.unknownError)
                return
            }
            
            var decodedData: APIResponseModel
            decodedData = try! JSONDecoder().decode(APIResponseModel.self, from: data!)
            self.latestAPIResponse = decodedData
            self.latestScannedURL = urlToCheck

            if decodedData.matches == nil {
                self.latestError = nil
                completion(true, nil)
                return
            } else {
                self.latestError = nil
                completion(false, nil)
                return
            }
        }
        dataTask.resume()
    }
}
