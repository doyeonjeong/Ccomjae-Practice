//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by Doyeon on 2023/02/09.
//

import UIKit

class TutorialContentsVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        // 이미지를 꽉 채울 수 있게
        self.bgImageView.contentMode = .scaleAspectFill
        
        // 전달받은 타이틀 정보를 레이블 객체에 대입하고 크기를 조절한다.
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        // 전달받은 이미지 정보를 이미지 뷰에 대입한다.
        self.bgImageView.image = UIImage(named: self.imageFile)
    }
    
}
