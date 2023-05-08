//
//  DarknetTxtToJsonController.swift
//  DarknetToJson
//
//  Created by Mac8 on 08/05/2023.
//

import Cocoa

class DarknetTxtToJsonController: NSViewController {
    @IBOutlet weak var optionView:NSView!
    @IBOutlet weak var filesCountLabel:NSTextField!
    
    @IBOutlet weak var inputView:DropView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.optionView.layer?.backgroundColor = NSColor.white.cgColor
        self.inputView.delegate = self
    }

    override var representedObject: Any? {
        didSet {

        }
    }
}

extension DarknetTxtToJsonController: FileURLsProvider {
    func inputFilesDidSelected(_ files: [String]) {
        self.filesCountLabel.stringValue = "\(files.count) file(s) selected"
        self.createJsonForFiles(files)
    }
    
    func createJsonForFiles(_ paths:[String]) {
        var allResponse = [DarknetTxtToJsonResponse]()
        for path in paths {
            print(path)
            do {
                let selectedFile = URL(filePath: path)
                    guard let content = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                
                    let fileName = selectedFile.lastPathComponent.replacingOccurrences(of: ".txt", with: ".jpg")
                
                    let fromURL = URL(filePath: "/Users/mac8/Desktop/images/\(fileName)")
                    let toURL = URL(filePath: "/Users/mac8/Desktop/dataset/\(fileName)")
                    try? FileManager.default.copyItem(at: fromURL, to: toURL)
                
                    defer { selectedFile.stopAccessingSecurityScopedResource() }
                    if content.count > 0  {
                        let data = content.components(separatedBy: " ")
                        let label = data[0]
                        let x = data[1].floatVal
                        let y = data[2].floatVal
                        let width = data[3].floatVal
                        let height = data[4].replacingOccurrences(of: "\r\n2", with: "").replacingOccurrences(of: "\r\n", with: "").floatVal
                        let option = DarknetTxtToJsonResponse(imagefilename: fileName, annotation: DarknetTxtToJsonResponse.Annotation(coordinates: DarknetTxtToJsonResponse.Coordinate(y: y, x: x, height: height, width: width), label: label))
                        allResponse.append(option)
                    }
            }
            catch {
                print("\(path) -> \(error.localizedDescription)")
            }
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(allResponse)
        print(String(data: data, encoding: .utf8)!)
    }
}
