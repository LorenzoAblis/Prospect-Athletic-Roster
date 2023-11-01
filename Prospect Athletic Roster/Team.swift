//
//  Team.swift
//  Prospect Athletic Roster
//
//  Created by Lorenzo J. Ablis on 10/26/23.
//

import Foundation

struct Team: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var season: String
    var coaches: [Coach]
    var players: [Player]
}

struct Coach: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var positon: String
}

struct Player: Hashable, Codable, Identifiable {
    var id: String
    var year: String
    var position: String
}
