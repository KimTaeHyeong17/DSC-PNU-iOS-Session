//
//  FriendData.swift
//  week2-practice
//
//  Created by 김태형 on 2020/05/16.
//  Copyright © 2020 김태형. All rights reserved.
//

import Foundation

struct FriendData{
    var name : String?
    var content : String?
    init (_ str : String, _ content : String){
        name = str
        self.content = content
    }
}
