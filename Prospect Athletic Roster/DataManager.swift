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
        fetchTeams {
            
        }
    }
    
    func fetchTeams(completion: @escaping () -> Void) {
        teams.removeAll()
        
        let database = Firestore.firestore()
        let collection = database.collection("teams")
        
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
                
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    
//    func fetchTeams() {
//        teams.removeAll()
//        let database = Firestore.firestore()
//        let collection = database.collection("teams")
//        
//        collection.getDocuments { team_snapshot, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//            
//            if let team_snapshot = team_snapshot {
//                for team_document in team_snapshot.documents {
//                    let team_data = team_document.data()
//                    var team = Team(id: "", name: "", season: "", coaches: [], players: [])
//                    
//                    let coaches_collection = team_document.reference.collection("coaches")
//                    
//                    coaches_collection.getDocuments { coach_snapshot, error in
//                        guard error == nil else {
//                            print(error!.localizedDescription)
//                            return
//                        }
//                        
//                        if let coach_snapshot = coach_snapshot {
//                            for coach_document in coach_snapshot.documents {
//                                let coach_data = coach_document.data()
//                                var coach = Coach(id: "", name: "", positon: "")
//                                
//                                coach.id = coach_document.documentID
//                                coach.name = coach_data["name"] as? String ?? ""
//                                coach.positon = coach_data["position"] as? String ?? ""
//                                
//                                team.coaches.append(coach)
//                            }
//                        }
//                    }
//                    
//                    team.id = team_document.documentID
//                    team.name = team_data["name"] as? String ?? ""
//                    team.season = team_data["season"] as? String ?? ""
//                    
//                    
//                    
//                    self.teams.append(team)
//                }
//            }
//            
//        }
//    }
}
