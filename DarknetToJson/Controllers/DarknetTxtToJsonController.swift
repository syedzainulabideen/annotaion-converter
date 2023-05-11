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
    @IBOutlet weak var toFolderPath:NSTextField!
    @IBOutlet weak var fromFolderPath:NSTextField!
    
    @IBOutlet weak var inputView:DropView!
    var currentConverter:ConvertableProtocol = TxtToJsonConverter()
    var txtFilesPath:[String] = [] {
        didSet {
            self.filesCountLabel.stringValue = "\(txtFilesPath.count) file(s) selected"
        }
    }
    
    var fromFolder:String = "" {
        didSet {
            self.fromFolderPath.stringValue = fromFolder.pathRepresentable
        }
    }
    var toFolder:String = "" {
        didSet {
            self.toFolderPath.stringValue = toFolder.pathRepresentable
        }
    }
    
    lazy var dialog:NSOpenPanel = {
        let dialog = NSOpenPanel();

        dialog.title                   = "Choose directory";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseFiles = false;
        dialog.canChooseDirectories = true;
        return dialog
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.optionView.layer?.backgroundColor = NSColor.white.cgColor
        self.inputView.delegate = self
        
        
        self.preferredContentSize = NSSize(width: 600, height: 400)
    }

    override var representedObject: Any? {
        didSet {

        }
    }
    
    func selectFolder(_ isTo:Bool) {
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if (result != nil) {
                let path: String = result!.path
                
                if isTo {
                    self.toFolder = path
                }
                else {
                    self.fromFolder = path
                }
            }
        }
        else {
            return
        }
    }
    
    @IBAction func selectFromFolder(_ button:NSButton) {
        selectFolder(false)
    }
    
    @IBAction func selectToFolder(_ button:NSButton) {
        selectFolder(true)
    }
    
    @IBAction func close(_ button:NSButton) {
        self.presentingViewController?.dismiss(self)
    }
    
    @IBAction func processFiles(_ button:NSButton) {
        guard self.txtFilesPath.count > 0 else {
            return
        }
        
        self.createJsonForFiles(txtFilesPath)
    }
    
    @IBAction func selectTxtFiles(_ button:NSButton) {
        let dialog = NSOpenPanel();

        dialog.title                   = "Choose .Txt Files";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = false;
        dialog.allowedFileTypes        = ["txt"];

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.urls // Pathname of the file
            if (result.count > 0) {
                self.txtFilesPath = result.map( { $0.path})
            }
        }
        else {
            return
        }
    }
}

extension DarknetTxtToJsonController: FileURLsProvider {
    func inputFilesDidSelected(_ files: [String]) {
        self.txtFilesPath = files
    }
    
    func createJsonForFiles(_ paths:[String]) {
        let allResponse:[DarknetTxtToJsonResponse] = self.currentConverter.convertGeneric(paths, fromPath: self.fromFolder, toPath: toFolder) ?? []
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(allResponse) else { return }
        
        guard let validString = String(data: data, encoding: .utf8), let toURL = URL(string: self.toFolder)?.appending(component: "annotation.json") else { return }
        if !FileManager.default.fileExists(atPath: toURL.path) {
            FileManager.default.createFile(atPath: toURL.path, contents: nil)
        }
        do {
            try validString.write(to: toURL, atomically: true, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
