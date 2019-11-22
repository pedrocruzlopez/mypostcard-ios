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
            headers : [String:String],
            completion: @escaping (Result<HTTPGenericResponse, Error>) -> Void){
        
        do{
            guard let resURL = URL(string: baseURL+endpoint) else { fatalError()}
            var urlRequest = URLRequest(url: resURL)
            urlRequest.httpMethod = type
            
            if(headers.count != 0){
                for (key, value) in headers {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data else {
                    print("error request")
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
        let headers = [String:String]()
        request(endpoint: "avatars.php", type: "GET", params: body, headers: headers) { result in
            switch(result){
            case .failure(_):
                completion(.failure(APIError.responseProblem))
            case .success(let response):
                completion(.success(response))
            }
        }
    }
    
    func getAddresses(completion: @escaping (Result<HTTPGenericResponse, Error>) -> Void){
        let body = [String]()
        let sessionToken = Session.shared.getSessionToken()
        if(Session.shared.getSessionToken() != ""){
            let headers:[String:String] = ["Myp-Auth": "Bearer "+sessionToken]
            request(endpoint: "mobile/sync_contacts.php?json=1&jwt=1&action=get_addressbook",
                    type: "POST",
                    params: body,
                    headers: headers) { (result) in
                        switch(result){
                        case .failure(_):
                            completion(.failure(APIError.responseProblem))
                        case .success(let response):
                            completion(.success(response))
                        }
            }
        } else {
            completion(.failure(APIError.responseProblem))
        }
    }
    
    func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    
    
}
