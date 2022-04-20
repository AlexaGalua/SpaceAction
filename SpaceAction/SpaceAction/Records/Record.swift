//
//  Record.swift
//  SpaceAction
//
//  Created by A on 4/14/22.
//

import Foundation


class Record: Codable {
    var score: Int?
    var date: String?
    
    init(score: Int?, date: String?) {
        self.score = score
        self.date = date
    }
}
