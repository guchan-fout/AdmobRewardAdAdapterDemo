//
//  AdsViewController.swift
//  AdManagerMediatonDemo
//
//  Created by Gu Chan on 2020/05/20.
//  Copyright © 2020 GuChan. All rights reserved.
//

import GoogleMobileAds
import UIKit


class AdsViewController: UIViewController,GADRewardedAdDelegate {

    var rewardedAd: GADRewardedAd?
    //var mUnitID = "/50378101/gc-test"
    var mUnitID = "ca-app-pub-2748478898138855/2704625864"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["ab9be09a17cc251676f8e647a02559cd"]
        rewardedAd = GADRewardedAd(adUnitID: mUnitID)
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["ab9be09a17cc251676f8e647a02559cd",(kGADSimulatorID as! String)]
        //rewardedAd = GADRewardedAd(adUnitID: mUnitID)
    }
    
    
    
    @IBAction func onCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loadRewardAd(_ sender: UIButton) {
    
        rewardedAd?.load(GADRequest()) { error in
          //self.adRequestInProgress = false
          if let error = error {
            print("Loading failed: \(error)")
          } else {
            print("Loading Succeeded")
            self.rewardedAd?.present(fromRootViewController: self, delegate:self)
          }
        }
    }
    
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        
        print("rewardedAd  userDidEarn.")
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad presented.")
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad dismissed.")
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
      print("Rewarded ad failed to present.")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
