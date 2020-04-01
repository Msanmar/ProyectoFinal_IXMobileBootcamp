//
//  DetectNetwork.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 22/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit
import SystemConfiguration


final class DetectNetwork {
    
  func connected() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        
        // Working for Cellular and WIFI
        let OK_NET = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let NOK_NET = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let result = (OK_NET && !NOK_NET)
        
        return result
        
        
    }
    
}
