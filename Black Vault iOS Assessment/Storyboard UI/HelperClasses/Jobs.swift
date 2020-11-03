//
//  Jobs.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/16/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

//   let jobs = try? newJSONDecoder().decode(Jobs.self, from: jsonData)

import Foundation

//MARK: - Jobs
//struct Jobs: Codable {
//    let data: DataClass
//    let meta: Meta
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let the20201016: [The20201016]
//
//    enum CodingKeys: String, CodingKey {
//        case the20201016
//    }
//}
//


// MARK: - The20201016
struct Jobs: Codable {
    let title: String
    let id: Int
    let key: String
    let date: DateClass
    let allowsFactoring: Bool
    let location: Location
    let distance: JSONNull?
    let url: String
    let maxPossibleEarningsHour, maxPossibleEarningsTotal: Double
    let client: Client
    let jobCategory: JobCategory
    let openPositions, newMatchesCount: Int
    let photo: String?
    let shifts: [Shift]

    enum CodingKeys: String, CodingKey {
        case title, id, key, date
        case allowsFactoring
        case location, distance, url
        case maxPossibleEarningsHour
        case maxPossibleEarningsTotal
        case client
        case jobCategory
        case openPositions
        case newMatchesCount
        case photo, shifts
    }
}

// MARK: - Client
struct Client: Codable {
    let name, id: String
    let photos: [Photo]
    let clientDescription: String
    let factoringAllowed: Bool
    let factoringPaymentTermInDays: Int
    let rating: Rating
    let avgResponseTimeInHours: Int

    enum CodingKeys: String, CodingKey {
        case name, id, photos
        case clientDescription
        case factoringAllowed
        case factoringPaymentTermInDays
        case rating
        case avgResponseTimeInHours
    }
}

// MARK: - Photo
struct Photo: Codable {
    let formats: [Format]
}

// MARK: - Format
struct Format: Codable {
    let cdnURL: String

    enum CodingKeys: String, CodingKey {
        case cdnURL
    }
}

// MARK: - Rating
struct Rating: Codable {
    let average: String
    let count: Int
}

// MARK: - DateClass
struct DateClass: Codable {
    let date: String
    let timezoneType: Int
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType
        case timezone
    }
}

// MARK: - JobCategory
struct JobCategory: Codable {
    let jobCategoryDescription, iconPath, slug: String

    enum CodingKeys: String, CodingKey {
        case jobCategoryDescription
        case iconPath
        case slug
    }
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: String
}

// MARK: - Shift
struct Shift: Codable {
    let id: String
    let tempersNeeded: Int
    let earningsPerHour: Double
    let duration: Int
    let currency, startDate, startTime, startDatetime: String
    let endTime, endDatetime: String
    let isAutoAcceptedWhenAppliedFor: Int

    enum CodingKeys: String, CodingKey {
        case id
        case tempersNeeded
        case earningsPerHour
        case duration, currency
        case startDate
        case startTime
        case startDatetime
        case endTime
        case endDatetime
        case isAutoAcceptedWhenAppliedFor
    }
}

// MARK: - Meta
struct Meta: Codable {
    let apiVersion: APIVersion

    enum CodingKeys: String, CodingKey {
        case apiVersion
    }
}

// MARK: - APIVersion
struct APIVersion: Codable {
    let current, latest: Int
    let released: Date
    let deprecationDate: JSONNull?

    enum CodingKeys: String, CodingKey {
        case current, latest, released
        case deprecationDate
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
