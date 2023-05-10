//
//  ConverterOption.swift
//  Annotation-Converter
//
//  Created by Mac8 on 09/05/2023.
//

import Foundation

enum ConverterOption: CaseIterable {
    case txtJson
    case jsonTxt
    case xmlJson
    case jsonXML
    case xmlTxt
    
    var enabled:Bool {
        switch self {
        case .txtJson:
            return true
        default:
            return false
        }
    }
    
    var fromValue:String {
        switch self {
        case .txtJson:
            return "TXT"
        case .jsonTxt, .jsonXML:
            return "JSON"
        case .xmlJson, .xmlTxt:
            return "XML"
        }
    }
    
    var toValue:String {
        switch self {
        case .txtJson, .xmlJson:
            return "JSON"
        case .jsonTxt, .xmlTxt:
            return "TXT"
        case .jsonXML:
            return "XML"
        }
    }
}
