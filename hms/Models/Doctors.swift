//
//  Doctors.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import Foundation
import SwiftUI

class Doctor: ObservableObject, Identifiable, Decodable {
    @Published var name: String
    @Published var department: String
    @Published var image: String
    @Published var rating: Double
    @Published var yearsOfExperience: Int
    @Published var registrationId: Int

    enum CodingKeys: String, CodingKey {
        case name
        case department
        case image
        case rating
        case yearsOfExperience
        case registrationId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.department = try container.decode(String.self, forKey: .department)
        self.image = try container.decode(String.self, forKey: .image)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.yearsOfExperience = try container.decode(Int.self, forKey: .yearsOfExperience)
        self.registrationId = try container.decode(Int.self, forKey: .registrationId)
    }
}
