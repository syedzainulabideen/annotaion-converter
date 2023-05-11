//
//  TxtToJsonConverter.swift
//  DarknetToJson
//
//  Created by Mac8 on 08/05/2023.
//

import Foundation

class TxtToJsonConverter: ConvertableProtocol {
    func convertGeneric(_ paths: [String], fromPath:String, toPath:String) -> [DarknetTxtToJsonResponse]? {
        var allResponse = [DarknetTxtToJsonResponse]()
        for path in paths {
            do {
                let selectedFile = URL(filePath: path)
                guard let content = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { continue }
                
                let fileName = selectedFile.lastPathComponent.replacingOccurrences(of: ".txt", with: ".jpg")
           
                
                defer { selectedFile.stopAccessingSecurityScopedResource() }
                let values = content.components(separatedBy: "\n")
                var annotations = [DarknetTxtToJsonResponse.Annotation]()
                for value in values {
                    if value.count > 0  {
                        let data = value.components(separatedBy: " ")
                        let label = data[0]
                        let x = data[1].floatVal
                        let y = data[2].floatVal
                        let width = data[3].floatVal
                        let height = data[4].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\r", with: "").floatVal
                        let anno = DarknetTxtToJsonResponse.Annotation(coordinates: DarknetTxtToJsonResponse.Coordinate(y: y, x: x, height: height, width: width), label: label)
                        annotations.append(anno)
                    }
                }
                
                if annotations.count > 0 {
                    let option = DarknetTxtToJsonResponse(imagefilename: fileName, annotation: annotations)
                    allResponse.append(option)
                    
                    let fromURL = URL(filePath: "\(fromPath)/\(fileName)")
                    let toURL = URL(filePath: "\(toPath)/\(fileName)")
                    try FileManager.default.moveItem(at: fromURL, to: toURL)
                }
            }
            catch {
                print("\(path) -> \(error.localizedDescription)")
            }
            
        }
        
        return allResponse
    }
    
}
