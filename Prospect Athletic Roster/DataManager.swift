//
//  DataManager.swift
//  Prospect Athletic Roster
//
//  Created by Lorenzo J. Ablis on 10/24/23.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import Firebase
import Foundation

class DataManager: ObservableObject {
    @Published var teams: [Team] = []
    
    init() {
        fetchTeams()
    }
    
    func fetchTeams() {
        teams.removeAll()
        let database = Firestore.firestore()
        let collection = database.collection("Teams")
        
        collection.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let players = data["players"] as? Int ?? 0
                    
                    let team = Team(name: name, players: players)
                    self.teams.append(team)
                }
            }
            
        }
    }
}
