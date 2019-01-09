//
//  Constants.swift
//  SpaceJump
//
//  Created by Catherine Smith on 1/8/19.
//  Copyright © 2019 Jacob Smith. All rights reserved.
//

import Foundation
import UIKit

struct ImageName {
    static let Background = "background"
    static let Ground = "appBackgroundGroundBricks"
    static let FlyingCarSit = "appPlayerCarNotFlying"
    static let FlyingCarFly = "appPlayerCar"
}

struct Layer {
    static let Background: CGFloat = 0
    static let Ground: CGFloat = 1
    static let FlyingCar: CGFloat = 1
}

struct PhysicsCategory {
    static let FlyingCar: UInt32 = 1
    static let Ground: UInt32 = 2
}
