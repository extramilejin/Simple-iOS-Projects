//
//  ToDoData.swift
//  ToDoList_Weekday
//
//  Created by 진형진 on 2021/02/19.
//

import UIKit

enum Complete {
    case None
    case Half
    case Done
}

class ToDoData {
    var todoIdx: Int?   // 데이터 식별값
    var date: Date? // 작성일
    var contents: String?   // ToDo 상세 내용
    var complete: Complete = .None // ToDo 완료 여부
    
    func updateComplete() {
            switch complete {
            case .None:
                complete = .Half
            case .Half:
                complete = .Done
            case .Done:
                complete = .None
            }
        }
}
