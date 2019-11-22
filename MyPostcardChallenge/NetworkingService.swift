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
    let baseURL = "https://www.mypostcard.com/"
    
    init() {
        guard let resourceURL = URL(string: baseURL ) else { fatalError() }
        self.resourceURL = resourceURL
    }

    func login (_ credentials: Message, completion: @escaping(Result<Response, Error>) -> Void){
    
        do{
            guard let resURL = URL(string: baseURL+"mobile/login.php?json") else { fatalError()}
            var urlRequest = URLRequest(url: resURL)
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
    
    func request(
            endpoint: String,
            type: String,
            params: [String],
            completion: @escaping (Result<HTTPGenericResponse, Error>) -> Void){
        
        do{
            guard let resURL = URL(string: baseURL+endpoint) else { fatalError()}
            var urlRequest = URLRequest(url: resURL)
            urlRequest.httpMethod = type
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data else {
                    completion(.failure(APIError.responseProblem))
                    return
                }
                do {
                    
                    print(responseData);
                    let messageData = HTTPGenericResponse(success: true, message: "Good, good", data: responseData)
                    completion(.success(messageData))
                }
                
            }
            dataTask.resume()
            
        }
    
    }
    
    func getAvatars(completion: @escaping (Result<HTTPGenericResponse, Error>) -> Void){
        
        let body = [String]()
        request(endpoint: "avatars.php", type: "GET", params: body) { result in
            switch(result){
            case .failure(let error):
                completion(.failure(APIError.responseProblem))
            case .success(let response):
                completion(.success(response))
            }
        }
    }
    
    func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    
    
}
