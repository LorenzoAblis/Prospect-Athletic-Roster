//
//  TeamView.swift
//  Prospect Athletic Roster
//
//  Created by Lorenzo J. Ablis on 11/1/23.
//

import SwiftUI

struct TeamView: View {
    @EnvironmentObject var dataManager: DataManager
    @State var teamID: String
    @State var name: String
    @State var season: String
    @State var coaches: [Coach]
    @State var players: [Player]
    
    @State var coachName = ""
    
    var body: some View {
        VStack {
            Text(name)
            
            ForEach(coaches, id: \.id) { coach in
                Text(coach.name)
            }
            
            TextField("Coach Name: ", text: $coachName)
            
            Button(action: {
                dataManager.addCoach(teamID: teamID, name: coachName, position: "")
            }) {
                Text("Add Coach")
            }
        }
    }
}

