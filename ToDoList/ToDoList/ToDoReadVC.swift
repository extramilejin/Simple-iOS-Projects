//
//  ToDoReadVC.swift
//  ToDoList
//
//  Created by 진형진 on 2021/02/16.
//

import UIKit

class ToDoReadVC: UIViewController {

    //MARK: Properties
    var param: ToDoData?
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
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
