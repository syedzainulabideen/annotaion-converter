//
//  Extensions.swift
//  DarknetToJson
//
//  Created by Mac8 on 08/05/2023.
//

import Foundation


extension String {
    var floatVal:Float {
        return (Float(self) ?? 0.0)
    }
    
    var pathRepresentable:String {
        let allComponents:[String] = self.components(separatedBy: "/").reversed()
        let lastThreeComponents:[String] = Array(allComponents.prefix(3)).reversed()
        return lastThreeComponents.joined(separator: " - ")
    }
}


enum ConverterError: Error {
    case unableToProcess
}
