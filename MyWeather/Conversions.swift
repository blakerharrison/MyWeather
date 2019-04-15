//
//  Conversions.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/15/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation

extension Int {
    var degreesToWindDirection: String {
        
        if self == 0 || self == 360 {
            return "N"
        }
        
        if self >= 1 && self <= 44 {
            return "NNE"
        }
        
        if self == 45 {
            return "NE"
        }
        
        if self >= 46 && self <= 89 {
            return "ENE"
        }
        
        if self == 90 {
            return "E"
        }
        
        if self >= 91 && self <= 134 {
            return "ESE"
        }
        
        if self == 135 {
            return "SE"
        }
        
        if self >= 136 && self <= 179 {
            return "SSE"
        }
        
        if self == 180 {
            return "S"
        }
        
        if self >= 181 && self <= 224 {
            return "SSW"
        }
        
        if self == 225 {
            return "SW"
        }
        
        if self >= 226 && self <= 269 {
            return "WSW"
        }
        
        if self == 270 {
            return "W"
        }
        
        if self >= 271 && self <= 314 {
            return "WNW"
        }
        
        if self == 315 {
            return "NW"
        }
        
        if self >= 316 && self <= 359 {
            return "NNW"
        }
        
        return ""
    }
}
