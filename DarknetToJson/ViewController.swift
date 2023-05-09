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
    
    @IBOutlet weak var collectionView:NSCollectionView!
    let photoItemIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "photoItemIdentifier")
    
    var currentOption = ConverterOption.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 800, height: 500)
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        
        self.leftContentView.layer?.backgroundColor = NSColor.purple.cgColor
        self.rightContentView.layer?.backgroundColor = NSColor.white.cgColor
        
        configureCollectionView()
    }
    
    override func viewWillAppear() {
        self.view.window?.isMovable = true
    }

    override var representedObject: Any? {
        didSet {

        }
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isSelectable = true
        collectionView.allowsEmptySelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.enclosingScrollView?.borderType = .noBorder
        collectionView.register(OptionItemView.self, forItemWithIdentifier: photoItemIdentifier)
//        collectionView.register(NSNib(nibNamed: "OptionItemView", bundle: nil), forItemWithIdentifier: photoItemIdentifier)
        configureFlowLayout()
    }
    

    func configureFlowLayout() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = NSEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        collectionView.collectionViewLayout = flowLayout
    }
    
    func txtToJsonButtonPressed(_ button:NSButton) {
        guard let controller:DarknetTxtToJsonController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "DarknetTxtToJsonController") as? DarknetTxtToJsonController else { return }
        self.view.window?.contentViewController = controller
    }
}


// MARK: - NSCollectionViewDataSource
extension ViewController: NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentOption.count
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        guard let item = collectionView.makeItem(withIdentifier: photoItemIdentifier, for: indexPath) as? OptionItemView else { return NSCollectionViewItem() }
        
        let option = self.currentOption[indexPath.item]
        item.configureCell(option.fromValue, to: option.toValue)
        return item
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {

        guard let indexPath = indexPaths.first else { return }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        let size = (collectionView.bounds.size.width - 70) / 3
        return NSSize(width: size, height: size)
    }
}
