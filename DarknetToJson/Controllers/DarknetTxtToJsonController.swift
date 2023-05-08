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
    var currentConverter:ConvertableProtocol = TxtToJsonConverter()
    var currentFiles:[String] = []
    
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
    
    @IBAction func processFiles(_ button:NSButton) {
        self.createJsonForFiles(currentFiles)
    }
}

extension DarknetTxtToJsonController: FileURLsProvider {
    func inputFilesDidSelected(_ files: [String]) {
        self.currentFiles = files
        self.filesCountLabel.stringValue = "\(currentFiles.count) file(s) selected"
    }
    
    func createJsonForFiles(_ paths:[String]) {
        let allResponse:[DarknetTxtToJsonResponse] = self.currentConverter.convertGeneric(paths) ?? []
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(allResponse) else { return }
        print(String(data: data, encoding: .utf8)!)
    }
}
