//
//  BaseTabBarController.swift
//  CloneGroo
//
//  Created by JOSUEYEON on 2022/10/06.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1 = Tab1ViewController()
        let tab2 = Tab2ViewController()
        let tab3 = Tab3ViewController()
        let tab4 = Tab4ViewController()
        let tab5 = Tab5ViewController()
    }
}
