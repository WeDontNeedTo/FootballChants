//
//  TeamTableViewCellDelegate.swift
//  FootballChants
//
//  Created by Danil Lomaev on 11.07.2021.
//

import Foundation

protocol TeamTableViewCellDelegate: AnyObject {
    func didTapPlayback(for team: Team)
}
