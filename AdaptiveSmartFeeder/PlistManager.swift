//
//  PlistManager.swift
//  MiniChallenge3
//
//  Created by Vítor Chagas on 06/12/16.
//  Copyright © 2016 grailgames. All rights reserved.
//

import Foundation

protocol PlistFormat {
    
    func setup(file: String) -> PlistFormat?
    func write(toFile: String)
}

extension NSMutableArray: PlistFormat {
    
    func setup(file: String) -> PlistFormat? {
        return NSMutableArray(contentsOfFile: file)
    }
    
    internal func write(toFile: String) {
        self.write(toFile: toFile, atomically: true)
    }
}

extension NSMutableDictionary: PlistFormat {
    
    func setup(file: String) -> PlistFormat? {
        return NSMutableDictionary(contentsOfFile: file)
    }
    
    internal func write(toFile: String) {
        self.write(toFile: toFile, atomically: true)
    }
}

protocol PlistManager: class {
    
    var properties: Plist { get set }
    
    func loadData()
    func saveData()
}

struct Plist {
    
    public private(set) var name: String
    
    private var data: PlistFormat?
    
    subscript (index: Int) -> Any? {
        
        get {
            if !(data is NSMutableArray) {
                return nil
            }
            return (data as! NSMutableArray)[index]
        }
        
        set(newValue) {
            if(newValue != nil && data is NSMutableArray) {
                (data as! NSMutableArray)[index] = newValue!
            }
        }
    }
    
    subscript (key: String) -> Any? {
        
        get {
            if !(data is NSMutableDictionary) {
                return nil
            }
            return (data as! NSMutableDictionary)[key]
        }
        
        set(newValue) {
            if(newValue != nil && data is NSMutableDictionary) {
                (data as! NSMutableDictionary)[key] = newValue!
            }
        }
    }
    
    var sourcePath: String? {
        return Bundle.main.path(forResource: name, ofType: "plist")
    }
    
    var destPath: String? {
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return "\(dir[0])/\(name).plist"
    }
    
    init?(withName name: String) {
        
        self.name = name
        
        guard let source = self.sourcePath else { return nil }
        guard let dest = self.destPath else { return nil }
        
        if(!FileManager.default.fileExists(atPath: dest)) {
            do {
                try FileManager.default.copyItem(atPath: source, toPath: dest)
            } catch {
                print("[Plist] Error: \(error.localizedDescription)")
            }
        }
        
        if(FileManager.default.fileExists(atPath: destPath!)) {
            
            let array = NSMutableArray(contentsOfFile: destPath!)
            let dict = NSMutableDictionary(contentsOfFile: destPath!)
            
            self.data = (array != nil) ? array : dict
        }
        
        // Use it to get the plist directory and delete if needed to
        //print("\n\n\nsource: \(source)\ndest: \(dest)\n\n\n")
        
    }
    
    func save() {
        //print(self.data)
        self.data?.write(toFile: self.destPath!)
    }
    
    func toArray() -> NSMutableArray? {
        return self.data as? NSMutableArray
    }
    
    func toDictionary() -> NSMutableDictionary? {
        return self.data as? NSMutableDictionary
    }
}



