//
//  ProtocolsHelper.swift
//  DarknetToJson
//
//  Created by Mac8 on 08/05/2023.
//

import Foundation

protocol FileURLsProvider: AnyObject {
    func inputFilesDidSelected(_ files:[String])
}


protocol ConvertableProtocol: AnyObject {
    func convertGeneric(_ paths: [String], fromPath:String, toPath:String) -> [DarknetTxtToJsonResponse]?
}
