//
//  Team.swift
//  FootballChants
//
//  Created by Danil Lomaev on 11.07.2021.
//

import Foundation

struct Team {
    let id: TeamType
    var name: String = ""
    var info: String = ""
    let manager: Manager
    var founded: String = ""
    var isPlaying: Bool = false
}
