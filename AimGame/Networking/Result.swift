//
//  Result.swift
//  AimGame
//
//  Created by Igor Belobrov on 02.09.2023.
//


import Foundation

struct Result: Codable {
    
    var winner: String?
    var loser: String?
    
    enum CodingKeys: String, CodingKey {
        case winner = "winner"
        case loser = "loser"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        winner = try values.decodeIfPresent(String.self, forKey: .winner)
        loser = try values.decodeIfPresent(String.self, forKey: .loser)
    }
}
