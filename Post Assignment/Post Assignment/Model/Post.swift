//
//  Post.swift
//  Post Assignment
//
//  Created by Admin on 13/02/21.
//  Copyright © 2021 Ghanshyam. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
