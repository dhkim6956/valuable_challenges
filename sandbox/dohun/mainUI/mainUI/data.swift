//
//  data.swift
//  mainUI
//
//  Created by 김도훈 on 2021/07/18.
//

import Foundation



struct Objective {
    let title: String
    let category: String
    let description: String
    let duration: Int
}

class  Objectives {
    var arrayList: [Objective]
    
    init() {
        arrayList = []
        
        arrayList.append(Objective(title: "독후감 작성하기", category: "독서", description: "독후감 작성후 촬영하여 인증", duration: 30) )
        arrayList.append(Objective(title: "독후감 작성하기", category: "독서", description: "독후감 작성후 촬영하여 인증", duration: 30) )
        arrayList.append(Objective(title: "독후감 작성하기", category: "독서", description: "독후감 작성후 촬영하여 인증", duration: 30) )
        
    }
}
