//
//  Status.swift
//  SwiftyInsta
//
//  Created by Mahdi on 10/30/18.
//  V. 2.0 by Stefano Bertagno on 7/31/19.
//  Copyright © 2018 Mahdi. All rights reserved.
//

import Foundation

/// A `protocol` referencing to everything holding an `Optional` **string** `status`.
protocol StatusEnforceable {
    /// The current `status`.
    var status: String? { get }
}

/// A basic `struct` conforming to `StatusEnforceable`.
public struct Status: Codable, StatusEnforceable {
    /// The current `state`.
    public enum State {
        case ok, fail, unknown
    }

    /// The current `status`.
    public var status: String?
    /// The current `state`.
    public var state: State {
        switch status?.lowercased() {
        case "ok"?: return .ok
        case "fail"?: return .fail
        default: return .unknown
        }
    }
}

/// A basic `struct` conforming to `StatusEnforceable`.
public struct Raw: Codable, ParsedResponse {
    
    public var rawResponse: DynamicResponse
    
    public init?(rawResponse: DynamicResponse) {
        guard rawResponse != .none else { return nil }
        self.rawResponse = rawResponse
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawResponse = try DynamicResponse(data: container.decode(Data.self))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawResponse.data())
    }

}
