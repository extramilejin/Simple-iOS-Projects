//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 진형진 on 2021/02/04.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    //MARK: IBOutlets
    @IBOutlet weak var userProfileButton: UIButton!
    
    
    //MARK: IBActions
    @IBAction func touchUpUserProfileButton(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func touchUpSignCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSignNextButton(_ sender: UIButton) {
        let signUpUserInfoViewController = SignUpUserInfoViewController()
        self.navigationController?.pushViewController(signUpUserInfoViewController, animated: true)
    }
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[.originalImage] as? UIImage {
            self.userProfileButton.setImage(originalImage, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
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
