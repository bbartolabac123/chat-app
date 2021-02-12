//
//  User.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/11/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var message: String
    var sender: String
    var created_at: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case sender
        case created_at
    }
}
