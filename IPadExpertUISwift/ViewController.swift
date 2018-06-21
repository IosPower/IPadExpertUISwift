//
//  ViewController.swift
//  IPadExpertUISwift
//
//  Created by piyush sinroja on 21/06/18.
//  Copyright © 2018 Piyush. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var viewMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setupUI()
        self.viewsAllSetLayout()
    }
    // MARK: - Method 2
    /// viewsAllSetLayout
    func viewsAllSetLayout() {
       // IPadPixelHelper.setConstraintAutomaticForIPad(constr: viewMain)
        IPadPixelHelper.setConstraintForIPadFromMainView(viewMain: viewMain, isSetFont: true, isSetFontWithPixel: true)
    }
}
