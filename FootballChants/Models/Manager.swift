//
//  Manager.swift
//  FootballChants
//
//  Created by Danil Lomaev on 11.07.2021.
//

import Foundation

struct Manager {
    var name: String = ""
    let job: Job
}

enum Job: String {
    case manager
    case headCoach = "head coach"
}
