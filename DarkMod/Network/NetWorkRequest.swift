//
//  NetWorkRequest.swift
//  DarkMod
//
//  Created by Test on 16/04/22.
//

import Foundation


class NetWorkRequest {
    
    static let shared = NetWorkRequest()
    
    private init() {}
    
    func requestData(urlString: String, complition: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                complition(.success(data))
            }
            
        }
        
        .resume()
    }
}
