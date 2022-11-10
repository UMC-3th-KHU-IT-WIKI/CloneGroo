//
//  Tab1ViewController.swift
//  CloneGroo
//
//  Created by JOSUEYEON on 2022/10/06.
//

import Foundation
import UIKit

class Tab1ViewController: UIViewController {
    let layout_tab1 = Tab1BaseLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout_tab1.initViews(self.view)
    }
}
