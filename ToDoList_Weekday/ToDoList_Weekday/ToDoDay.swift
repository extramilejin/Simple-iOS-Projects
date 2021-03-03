//
//  ToDoDay.swift
//  ToDoList_Weekday
//
//  Created by 진형진 on 2021/02/19.
//

import Foundation

class ToDoDay {
    var date: String
    var todo: [ToDoData]
    
    init(date: String) {
        var dummyData1: ToDoData = ToDoData()
        dummyData1.contents = "일기쓰기"
        var dummyData2: ToDoData = ToDoData()
        dummyData2.contents = "밥 먹기"
        self.date = date
        let testData: [ToDoData] = [dummyData1, dummyData2]
        self.todo = testData
    }
    
    init(date: String, todo: [ToDoData]) {
        self.date = date
        self.todo = todo
    }
}
