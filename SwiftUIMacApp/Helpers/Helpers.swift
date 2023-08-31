//
//  Helpers.swift
//  SwiftUIMacApp
//
//  Created by Arda Ilgili on 31.08.2023.
//

import Foundation

class Helpers {
    static func stringArrayToData(stringArray: [String]) -> Data? {
      return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }

    static func dataToStringArray(data: Data) -> [String]? {
      return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
    }
}
