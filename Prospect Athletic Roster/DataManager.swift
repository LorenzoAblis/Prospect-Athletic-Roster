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
//        fetchTeams {}
    }
    
    func fetchTeams() {
        teams.removeAll()
        
        let db = Firestore.firestore()
        let collection = db.collection("teams")
        
        Task {
            do {
                let team_snapshot = try await collection.getDocuments()
                
                for team_document in team_snapshot.documents {
                    var team = Team(id: team_document.documentID, name: "", season: "", coaches: [], players: [])
                    let team_data = team_document.data()
                    
                    let coaches_collection = team_document.reference.collection("coaches")
                    let coach_snapshot = try await coaches_collection.getDocuments()
                    
                    for coach_document in coach_snapshot.documents {
                        var coach = Coach(id: coach_document.documentID, name: "", positon: "")
                        let coach_data = coach_document.data()
                        
                        coach.name = coach_data["name"] as? String ?? ""
                        coach.positon = coach_data["position"] as? String ?? ""
                        team.coaches.append(coach)
                    }
                    
                    team.name = team_data["name"] as? String ?? ""
                    team.season = team_data["season"] as? String ?? ""
                    
                    self.teams.append(team)
                }
                
//                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func addTeam(name: String, season: String) {
        let db = Firestore.firestore()
        let team_collection = db.collection("teams")
        
        team_collection.document().setData(["name": name, "season": season]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        fetchTeams()
//        fetchTeams {}
    }
    
    func deleteteam(teamID: String) {
        let db = Firestore.firestore()
        let team_collection = db.collection("teams")
        
        team_collection.document(teamID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            }
            else {
                print("Document successfully removed!")
            }
        }
        
        fetchTeams()
//        fetchTeams {}
    }
    
    func addCoach(teamID: String, name: String, position: String) {
        let db = Firestore.firestore()
        let coaches_collection = db.collection("teams").document(teamID).collection("coaches")
        
        coaches_collection.document().setData(["name": name, "position": position]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        fetchTeams()
//        fetchTeams {}
    }
    
}
