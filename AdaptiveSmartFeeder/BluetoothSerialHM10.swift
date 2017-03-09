//
//  BluetoothSerialHM10.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 02/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import CoreBluetooth


class BluetoothSerialHM10: BluetoothSerialDelegate {
    
    public static var instance = BluetoothSerialHM10()
    
    private var pendingCommands = [String]()
    
    private init() {
        serial = BluetoothSerial(delegate: self)
    }
    
    func addCommand(_ command: BluetoothCommand) {
        
        self.pendingCommands.append(command.description)
        self.sendCommand()
    }
    
    private func sendCommand() {
        
        let pendingCommand = self.pendingCommands.first!
        
        // if connected
        if serial.connectedPeripheral != nil {
            let data = pendingCommand.data(using: .utf8)!
            serial.sendDataToDevice(data)
            print("Sent: \(pendingCommand)")
            self.pendingCommands.removeFirst()
            if !self.pendingCommands.isEmpty { self.sendCommand() }
        }
        // else if discovered but not connected
        else if let pendingPeripheral = serial.pendingPeripheral {
            serial.connectToPeripheral(pendingPeripheral)
        }
        // else if not discovered
        else {
            serial.startScan()
        }
    }
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        
        if peripheral.name == "HMSoft" {
            print("Discovered HMSoft, trying to connect...")
            serial.stopScan()
            serial.connectToPeripheral(peripheral)
        }
    }
    
    func serialDidConnect(_ peripheral: CBPeripheral) {
        
        print("Connected to HMSoft")
        if !self.pendingCommands.isEmpty {
            self.sendCommand()
        }
    }
    
    func serialDidChangeState() {
        
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        print("Disconnected from HMSoft")
    }
    
}
