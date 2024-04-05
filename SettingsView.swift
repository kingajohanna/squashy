//
//  SettingsView.swift
//  squashy Watch App
//
//  Created by Szabó Kinga on 22/03/2024.
//

import SwiftUI

struct SettingsView: View {    
    @ObservedObject var userpair: UserPair
    
//    func restore_actual_user(actual_user: UserScore, other_user: UserScore, mem: UserScoreMemento) {
//        actual_user.restore(memento: mem)
//        if !mem.is_serving {
//            other_user.is_serving = true
//            other_user.update_serving()
//        } else {
//            
//        }
//    }
    
    var body: some View {
        VStack{
            Button(action: {
                let mem = get_memento_store().get_memento()
                guard let unwrap_mem = mem else {
                    return
                }
                userpair.restore(mem: unwrap_mem)
            }, label: {
                Image(systemName: "arrow.uturn.left.circle.fill").resizable().frame(width: 20, height: 20).padding(10)
                Text("Undo")
            }).buttonStyle(.borderedProminent).tint(.blue)
            Spacer()
            Button(action: {
                userpair.reset_game()
            }, label: {
                Image(systemName: "arrow.2.circlepath.circle.fill").resizable().frame(width: 20, height: 20).padding(10)
                Text("Reset")
            }).buttonStyle(.borderedProminent).tint(.red)
        }
        
    }
}
