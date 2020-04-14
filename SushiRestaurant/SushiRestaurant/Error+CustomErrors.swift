//
//  Error+CustomErrors.swift
//  SushiRestaurant
//
//  Created by Richard Cho on 2/28/20.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

enum RuntimeError: Error {
    case illegalArgumentError(String)
}
