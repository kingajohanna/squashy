//
//  UserButton.swift
//  squashy Watch App
//
//  Created by Szabó Kinga on 22/03/2024.
//

import SwiftUI

struct UserButton: View {
    @ObservedObject var user: UserScore
    let action: () -> ()
    
    var body: some View {
        GeometryReader{ geometry in
            Button(action: {action()}, label: {

                    HStack {
                        Text(self.user.name)
                        
                        if self.user.is_serving {
                            Image(systemName: "circle.fill").resizable().frame(width: 8.0, height: 8.0)
                        }
                        Spacer()
                        HStack {
                            Text(String(self.user.set)).frame(width: 20)
                            Spacer()
                            Text("|")
                            Spacer()
                            Text(String(self.user.game)).frame(width: 20)
                        }.frame(width: geometry.size.width/3)
                    }.frame(height:200)
            }).buttonStyle(.borderedProminent)
              .buttonBorderShape(.roundedRectangle(radius: 16))
              .tint(user.bg_color)
        }
    }
}
