//
//  TeamView.swift
//  Prospect Athletic Roster
//
//  Created by Brock R. Wrede on 11/7/23.
//

import SwiftUI

struct TeamView: View {
    @ObservedObject var dataManager: DataManager
    @State var team: Team
    @State var visiblePlayerDetails = ""
    @State var isAddingPlayer = false
    
    @State var newPlayer = Player(id: "", name: "", position: "", year: "")
    
    var body: some View {
        ScrollView {
            VStack {
                Text(team.name)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Season:")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Text(team.season)
                }
                ForEach(team.coaches, id: \.self) { coach in
                    HStack {
                        Text("\(coach.positon):")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                        Text(coach.name)
                    }
                }
            }
            Spacer(minLength: 10)
            
            HStack {
                Text("Players")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Button(action: {
                    isAddingPlayer.toggle()
                }) {
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 25))
                }
                Spacer()
            }
            
            if isAddingPlayer {
                VStack {
                    Text("Add Player")
                    VStack {
                        TextField("Name", text: $newPlayer.name)
                            .textFieldStyle(.roundedBorder)
                        TextField("Year", text: $newPlayer.year)
                            .textFieldStyle(.roundedBorder)
                        TextField("Position", text: $newPlayer.position)
                            .textFieldStyle(.roundedBorder)
                        Button(action: {
                            Task {
                                await dataManager.updatePlayer(updateType: UpdateType.add, teamID: team.id, playerID: "", name: newPlayer.name, position: newPlayer.position, year:newPlayer.year)
                                await dataManager.fetchTeams()                        }
                        }) {
                            Text("Add")
                        }
                    }
                }.font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            VStack(alignment: .leading) {
                ForEach(team.players, id: \.self) { player in
                    Button(action: {
                        if visiblePlayerDetails == player.id {
                            visiblePlayerDetails = ""
                        } else {
                            visiblePlayerDetails = player.id
                        }
                    }) {
                        Text(player.name)
                            .font(.system(size: 30))
                    }
                    
                    if visiblePlayerDetails == player.id {
                        VStack(alignment: .leading) {
                            Text("Year: \(player.year)")
                            Text("Position: \(player.position)")
                        }.padding(1)
                    }
                }
            }
            
            
            Spacer()
        }
    }
}
