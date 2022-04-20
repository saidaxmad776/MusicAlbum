//
//  NetworkDataFetch.swift
//  DarkMod
//
//  Created by Test on 16/04/22.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, responce: @escaping (AlbumModel?, Error?) -> Void) {
        
        NetWorkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
    
    func fetchSong(urlString: String, responce: @escaping (SongsModel?, Error?) -> Void) {
        
        NetWorkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(SongsModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
