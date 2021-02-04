//
//  LoginViewController.swift
//  SignUp
//
//  Created by 진형진 on 2021/02/04.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    //MARK: IBOutlets
    @IBOutlet weak var loginUserID: UITextField!
    @IBOutlet weak var loginUserPassword: UITextField!
    
    
    //MARK: IBAction
    @IBAction func tappedView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func touchUpLoginButton(_ sender: UIButton) {
        var title: String
        var message: String
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

