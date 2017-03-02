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
    
    public var pendingCommand: String?
    
    private init() {
        serial = BluetoothSerial(delegate: self)
        pendingCommand = nil
    }
    
    func sendCommand() {
        
        guard let pendingCommand = self.pendingCommand else { return }
        
        if serial.connectedPeripheral != nil {
            let data = pendingCommand.data(using: .utf8)!
            serial.sendDataToDevice(data)
            self.pendingCommand = nil
        }
        else if let pendingPeripheral = serial.pendingPeripheral {
            serial.connectToPeripheral(pendingPeripheral)
        }
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
        self.sendCommand()
    }
    
    func serialDidChangeState() {
        
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        print("Disconnected drom HMSoft")
    }
    
}
