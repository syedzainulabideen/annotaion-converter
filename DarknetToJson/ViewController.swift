//
//  ViewController.swift
//  DarknetToJson
//
//  Created by Mac8 on 03/05/2023.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var leftContentView:NSView!
    @IBOutlet weak var rightContentView:NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 800, height: 500)
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        
        self.leftContentView.layer?.backgroundColor = NSColor.purple.cgColor
        self.rightContentView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
    }
    
    override func viewWillAppear() {
        self.view.window?.isMovable = true
    }

    override var representedObject: Any? {
        didSet {

        }
    }
    
    @IBAction func txtToJsonButtonPressed(_ button:NSButton) {
        guard let controller:DarknetTxtToJsonController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "DarknetTxtToJsonController") as? DarknetTxtToJsonController else { return }
        self.view.window?.contentViewController = controller
    }
}


