//
//  PhysicsCategory.swift
//  physicsTest2
//
//  Created by Krish Bothra on 1/29/24.
//


import Foundation

struct PhysicsCategory {
    
    static let player: UInt32 = 0b1     // 1
    static let spike: UInt32 = 0b1 << 1 // 2
    static let bullet: UInt32 = 0b1
}
