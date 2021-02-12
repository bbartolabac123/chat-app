//
//  User.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/11/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var password: String
    var username: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case password
        case username
    }
}
