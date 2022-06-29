//
//  GetURL.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

extension String {
    func getURL() -> URL? {
        return URL(string: self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
    
    func lowerCasingFirstLetter() -> String {
        return prefix(1).lowercased() + self.dropFirst()
    }
    
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = incomingFormat
      dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

      let dt = dateFormatter.date(from: self)
      dateFormatter.timeZone = TimeZone.current
      dateFormatter.dateFormat = outGoingFormat

      return dateFormatter.string(from: dt ?? Date())
    }
}
