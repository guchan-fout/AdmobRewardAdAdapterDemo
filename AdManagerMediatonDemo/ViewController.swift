//
//  ViewController.swift
//  AdManagerMediatonDemo
//
//  Created by Gu Chan on 2020/05/20.
//  Copyright © 2020 GuChan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showAds(_ sender: UIButton) {
        performSegue(withIdentifier: "adsSegue", sender: self)
    }
}

