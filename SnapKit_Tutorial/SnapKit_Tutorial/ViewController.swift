//
//  ViewController.swift
//  SnapKit_Tutorial
//
//  Created by 진형진 on 2021/03/19.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(box)
        box.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        box.backgroundColor = .green
    }
}
