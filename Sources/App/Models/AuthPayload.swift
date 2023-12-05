//
//  File.swift
//  
//
//  Created by Igor Łopatka on 05/12/2023.
//

import Foundation
import JWT


struct AuthPayload: JWTPayload {
    
    typealias Payload = AuthPayload
    
    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case userID = "uid"
    }
    
    var expiration: ExpirationClaim
    var userID: UUID
    
    func verify(using signer: JWTKit.JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}
