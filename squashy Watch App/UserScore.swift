//
//  UserScore.swift
//  squashy Watch App
//
//  Created by Szabó Kinga on 22/03/2024.
//

import Foundation
import SwiftUI

class UserPairMemento {
    let user1_mem: UserScoreMemento
    let user2_mem: UserScoreMemento
    
    init(user1_mem: UserScoreMemento, user2_mem: UserScoreMemento) {
        self.user1_mem = user1_mem
        self.user2_mem = user2_mem
    }
}

class UserScoreMemento {
    var set: Int
    var is_serving: Bool
    var game: Int
    var bg_color: Color
    var started: Bool
    
    init(set: Int, is_serving: Bool, game: Int, bg_color: Color, started: Bool) {
        self.set = set
        self.is_serving = is_serving
        self.game = game
        self.bg_color = bg_color
        self.started = started
    }
}

class UserPair : ObservableObject{
    @Published var user1: UserScore
    @Published var user2: UserScore
    var user1_started_game: Bool
    
    init(user1: UserScore, user2: UserScore) {
        self.user1 = user1
        self.user2 = user2
        self.user1_started_game = user1.started
    }
    
    func get_memento() -> UserPairMemento {
        return UserPairMemento(user1_mem: user1.get_memento(), user2_mem: user2.get_memento())
    }
    
    func restore(mem: UserPairMemento) {
        self.user1.restore(memento: mem.user1_mem)
        self.user2.restore(memento: mem.user2_mem)
    }
    
    func update_user_properties(this_user: UserScore, other_user: UserScore) -> () -> () {
        let update: () -> () = {
            let mem = self.get_memento()
            get_memento_store().add_memento(mem: mem)
            this_user.game += 1
            let setstate = this_user.check_if_valid_update_game(other_user: other_user)
            if setstate == SetState.ongoing {
                this_user.update_serving()
                other_user.is_serving = false
                other_user.bg_color = Color.gray
            } else {
                if this_user.started {
                    this_user.reset_set()
                    other_user.start_set()
                } else {
                    other_user.reset_set()
                    this_user.start_set()
                }
            }

        }
        return update
    }
    
    func user1_scores() -> () -> () {
        return self.update_user_properties(this_user: self.user1, other_user: self.user2)
    }
    
    func user2_scores() -> () -> () {
        return self.update_user_properties(this_user: self.user2, other_user: self.user1)
    }
    
    func reset_game() {
        self.user1_started_game = !self.user1_started_game
        user1.reset(started: self.user1_started_game)
        user2.reset(started: !self.user1_started_game)
    }
}

enum SetState {
    case ongoing, finished
}

class UserScore : ObservableObject {
    static let max_game_score: Int = 11
    let name: String
    var started: Bool
    @Published var set = 0
    @Published var is_serving = true
    @Published var bg_color = Color.gray
    @Published var game = 0
    
    init(name: String, started: Bool) {
        self.name = name
        self.is_serving = started
        self.started = started
    }
    
    func check_if_valid_update_game(other_user: UserScore) -> SetState {
        if self.game >= UserScore.max_game_score && other_user.game <= self.game - 2 {
            self.set += 1
            self.game = 0
            other_user.game = 0
            return SetState.finished
        }
        return SetState.ongoing
    }
    func start_set() {
        self.is_serving = true
        self.started = true
        self.bg_color = Color.gray
    }
    func reset_set() {
        self.is_serving = false
        self.started = false
        self.bg_color = Color.gray
    }
    func update_serving() {
        self.bg_color = self.is_serving == true ? Color.purple : Color.gray
        self.is_serving = true
    }
    
    func get_memento() -> UserScoreMemento {
        return UserScoreMemento(set: self.set, is_serving: self.is_serving, game: self.game, bg_color: self.bg_color, started: self.started)
    }
    
    func restore(memento: UserScoreMemento) {
        self.set = memento.set
        self.is_serving = memento.is_serving
        self.game = memento.game
        self.bg_color = memento.bg_color
    }
    
    func reset(started: Bool) {
        self.set = 0
        self.game = 0
        self.bg_color = Color.gray
        self.started = started
        self.is_serving = started
    }
}
