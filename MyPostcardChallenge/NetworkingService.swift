//
//  NetworkingService.swift
//  MyPostcardChallenge
//
//  Created by user on 11/19/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation

enum APIError: Error{
    case responseProblem
    case decodingProblem
    case otherProblem
}

class NetworkingService {
    
    let resourceURL: URL
    let baseURL = "https://www.mypostcard.com/mobile/login.php?json"
    
    init() {
        guard let resourceURL = URL(string: baseURL ) else { fatalError() }
        self.resourceURL = resourceURL
    }

    func login (_ credentials: Message, completion: @escaping(Result<Response, Error>) -> Void){
    
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let body = HTTPUtils.formUrlencode([
                "email": credentials.email,
                "password": credentials.password
            ])
            
            urlRequest.httpBody = body.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(APIError.responseProblem))
                    return
                }
                do {
                    let messageData = try JSONDecoder().decode(Response.self, from: jsonData)
                    completion(.success(messageData))
                }
                catch {
                    print("error: \(error)")
                    completion(.failure(APIError.otherProblem))
                }
            }
            dataTask.resume()
        }
        
    }
    
}
