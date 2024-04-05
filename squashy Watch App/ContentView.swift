//
//  ContentView.swift
//  squashy Watch App
//
//  Created by Szabó Kinga on 22/03/2024.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var userpair: UserPair
    
    
    
    var body: some View {
        VStack {
            UserButton(user: userpair.user1, action: userpair.user1_scores())
//                UserButton(user: user1).onChange(of: user1.game){
//                    update_user_properties(this_user: user1, other_user: user2)
//                }

            
            UserButton(user: userpair.user2, action: userpair.user2_scores())
//            UserButton(user: user2).onChange(of: user2.game){
//                update_user_properties(this_user: user2, other_user: user1)
//            }
            
        }
    }
}
