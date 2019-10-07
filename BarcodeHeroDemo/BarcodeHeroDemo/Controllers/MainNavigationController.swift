//
//  MainNavigationController.swift
//  BarcodeHeroDemo
//
//  Created by Brian Drelling on 11/8/17.
//  Copyright © 2017 SpotHero, Inc. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}
