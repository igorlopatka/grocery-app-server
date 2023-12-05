//
//  File.swift
//  
//
//  Created by Igor Łopatka on 04/12/2023.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content {
    
    let error: Bool
    var reason: String? = nil
}
