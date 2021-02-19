//
//  ToDoFormVC.swift
//  ToDoList
//
//  Created by 진형진 on 2021/02/16.
//

import UIKit

class ToDoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    //MARK: Properties
    var subject: String!
    
    //MARK: Outlets
    @IBOutlet weak var todoContents: UITextView!
    @IBOutlet weak var todoPreview: UIImageView!
    
    //MARK: Actions
    @IBAction func touchUpSaveButton(_ sender: UIBarButtonItem) {
        // 내용이 입력되지 않았을 경우 경고창 실행
        guard self.todoContents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: false)
            return
        }
        
        let data = ToDoData()
        data.title = self.subject
        data.contents = self.todoContents.text
        data.image = self.todoPreview.image
        data.date = Date()
        
        // 앱 델리게이트 객체를 읽어온 후, todoList 배열에 객체 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.todoList.append(data)
        
        // 작성폼 화면 종료
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpPickButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택하세요", preferredStyle: .actionSheet)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true // 이미지 편집 여부
        
        alert.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
            picker.sourceType = .camera
            self.present(picker, animated: false, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "앨범", style: .default) { (_) in
            self.present(picker, animated: false, completion: nil)
        })
        self.present(alert, animated: true)
    }
    
    //MARK: UIImagePickerControllerDelegate
    // 사용자가 이미지 선택 시 델리게이트 메소드 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.todoPreview.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoContents.delegate = self

        // Do any additional setup after loading the view.
    }
    
    //MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        // NSString 과 String 타입은 완전 호환이므로 as? 쓸 필요 x
        let contents = textView.text as NSString
        let length = (contents.length > 15) ? 15 : contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        // 사용자가 상세 내용 작성 시 내용의 첫 줄 15글자를 ToDo 제목으로 설정
        self.navigationItem.title = self.subject
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
