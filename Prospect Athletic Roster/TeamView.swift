//
//  TeamView.swift
//  Prospect Athletic Roster
//
//  Created by Brock R. Wrede on 11/7/23.
//

import SwiftUI

struct TeamView: View {
    @State var teamID: String
    
//    var about: String
//    var coaches: [[String: String]]
//    var players: [[String: String]]
    
    
    var body: some View {
        VStack {
//            Text(about)
            VStack {
                Text("Coaches")
//                ForEach(dataManager.teams, id: \.self) { team in
//                    HStack {
////                        Text(coach["name"]!)
////                        Text(coach["position"]!)
//                    }
                
//                    ForEach(players, id: \.self) { player in
//                        HStack {
//                            Text(player["name"]!)
//                            Text(player["position"]!)
//                            Text(player["year"]!)
//                        }
//
//                    }
                }
            }
        }
    }
    
    struct TeamView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(DataManager())
        }
    }
