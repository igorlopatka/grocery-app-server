//
//  File.swift
//  
//
//  Created by Igor Łopatka on 05/12/2023.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content {
    
    let error: Bool
    var reason: String? = nil
    var token: String? = nil
    var userID: UUID? = nil
}
