//
//  WrapperAdapter.swift
//  AdManagerMediatonDemo
//
//  Created by Gu Chan on 2020/05/22.
//  Copyright © 2020 GuChan. All rights reserved.
//

import UIKit

class WrapperAdapter: NSObject,GADMRewardBasedVideoAdNetworkAdapter {
    static func adapterVersion() -> String! {
        print("adapterVersion")
        return "1.0"
    }
    
    static func networkExtrasClass() -> GADAdNetworkExtras.Type! {
        print("networkExtrasClass")
        return GADAdNetworkExtras.self
    }
    
    required init!(rewardBasedVideoAdNetworkConnector connector: GADMRewardBasedVideoAdNetworkConnector!) {
         print("111")
    }
    
    func setUp() {
         print("222")
    }
    
    func requestRewardBasedVideoAd() {
         print("333")
    }
    
    func presentRewardBasedVideoAd(withRootViewController viewController: UIViewController!) {
        print("444")
    }
    
    func stopBeingDelegate() {
        print("555")
    }
    
    required init!(rewardBasedVideoAdNetworkConnector connector: GADMRewardBasedVideoAdNetworkConnector!, credentials: [[AnyHashable : Any]]!) {
        print("666")
    }
    
    required init!(gadmAdNetworkConnector connector: GADMRewardBasedVideoAdNetworkConnector!) {
        print("777")
    }
    

}
