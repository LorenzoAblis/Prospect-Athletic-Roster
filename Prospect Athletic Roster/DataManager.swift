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
    
    func fetchTeams() async {
        teams.removeAll()
        
        let db = Firestore.firestore()
        let collection = db.collection("teams")
        
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
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTeam(updateType: UpdateType, teamID: String, name: String, season: String) async {
        let db  = Firestore.firestore()
        let teams_collection = db.collection("teams")
        
        do {
            switch updateType {
            case UpdateType.add:
                try await teams_collection.document().setData(["name": name, "season": season]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
                await fetchTeams()
            case UpdateType.remove:
                try await teams_collection.document(teamID).delete() { err in
                    if let err = err {
                        print("Error removing team: \(err)")
                    }
                }
                
                await fetchTeams()
            default:
                print("Error in updating coach data")
            }
        }
    }
    
    func updateCoach(updateType: UpdateType, teamID: String, coachID: String, name: String, position: String) async {
        let db = Firestore.firestore()
        let coaches_collection = db.collection("teams").document(teamID).collection("coaches")
        
        do {
            switch updateType {
            case UpdateType.add:
                try await coaches_collection.document().setData(["name": name,
                                                                 "position": position]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            case UpdateType.remove:
                try await coaches_collection.document(coachID).delete() { error in
                    if let error = error {
                        print("Error removing coach: \(error)")
                    }
                }
            default:
                print("Error in updating coach data")
            }
            
            await fetchTeams()
        }
    }
    
    func updatePlayer(updateType: UpdateType, teamID: String, playerID: String, name: String, position: String, year: String) async {
        let db = Firestore.firestore()
        let players_collection = db.collection("teams").document(teamID).collection("players")
        
        do {
            switch updateType {
            case UpdateType.add:
                try await players_collection.document().setData(["name": name,
                                                                 "position": position,
                                                                 "year": year]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            case UpdateType.remove:
                try await players_collection.document(playerID).delete() { error in
                    if let error = error {
                        print("Error removing player: \(error)")
                    }
                }
            default:
                print("Error in updating player data")
            }
            
            await fetchTeams()
        }
    }
    
//    func addTeam(name: String, season: String) async {
//        let db = Firestore.firestore()
//        let team_collection = db.collection("teams")
//        
//        do {
//            try await team_collection.document().setData(["name": name, "season": season]) { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//            
//            await fetchTeams()
//        } catch {
//            print("Error adding team: \(error)")
//        }
//        
//    }
//    
//    func deleteTeam(teamID: String) async {
//        let db = Firestore.firestore()
//        let teams_collection = db.collection("teams")
//        
//        do {
//            try await teams_collection.document(teamID).delete() { err in
//                if let err = err {
//                    print("Error removing document: \(err)")
//                }
//                else {
//                    print("Document successfully removed!")
//                }
//            }
//            
//            await fetchTeams()
//        } catch {
//            print("Error deleting team: \(error)")
//        }
//    }
    
    //    func addCoach(teamID: String, name: String, position: String) async {
    //        let db = Firestore.firestore()
    //        let coaches_collection = db.collection("teams").document(teamID).collection("coaches")
    //
    //        do {
    //            try await coaches_collection.document().setData(["name": name, "position": position]) { error in
    //                if let error = error {
    //                    print(error.localizedDescription)
    //                }
    //            }
    //
    //            await fetchTeams()
    //        } catch {
    //            print("Error adding coach: \(error)")
    //        }
    //    }
    //
    //    func deleteCoach(teamID: String, coachID: String) async {
    //        let db = Firestore.firestore()
    //        let coaches_collection = db.collection("teams").document(teamID).collection("coaches")
    //
    //        do {
    //            try await coaches_collection.document(coachID).delete() { err in
    //                if let err = err {
    //                    print("Error removing document: \(err)")
    //                }
    //                else {
    //                    print("Document successfully removed!")
    //                }
    //            }
    //
    //            await fetchTeams()
    //        } catch {
    //            print("Error deleting coach: \(error)")
    //        }
    //    }
    
    //    func addPlayer(teamID: String, name: String, position: String, year: String) async {
    //        let db = Firestore.firestore()
    //        let players_collection = db.collection("teams").document(teamID).collection("players")
    //
    //        do {
    //            try await players_collection.document().setData(["name": name,
    //                                                             "position": position,
    //                                                             "year": year]) { error in
    //                if let error = error {
    //                    print(error.localizedDescription)
    //                }
    //            }
    //
    //            await fetchTeams()
    //        } catch {
    //            print("Error adding player: \(error)")
    //        }
    //    }
    
    //    func deletePlayer(teamID: String, playerID: String) async {
    //        let db = Firestore.firestore()
    //        let players_collection = db.collection("teams").document(teamID).collection("players")
    //
    //        do {
    //            try await players_collection.document(playerID).delete() { err in
    //                if let err = err {
    //                    print("Error removing player: \(err)")
    //                }
    //                else {
    //                    print("Player successfully removed!")
    //                }
    //            }
    //
    //            await fetchTeams()
    //        } catch {
    //            print("Error deleting player: \(error)")
    //        }
    //    }
    
    
}
