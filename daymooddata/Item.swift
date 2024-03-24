//
//  Item.swift
//  daymooddata
//
//  Created by Diana Hernández on 24/3/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
