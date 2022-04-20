//
//  SongsModel.swift
//  DarkMod
//
//  Created by Test on 20/04/22.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
