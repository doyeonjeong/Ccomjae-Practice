//
//  SideBarVC.swift
//  MyMemory
//
//  Created by Doyeon on 2023/02/06.
//

import UIKit

class SideBarVC: UITableViewController {
    
    let uinfo = UserInfoManager()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    /// 목록 데이터 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    /// 아이콘 테이터 배열
    let icons = [
        UIImage(named: "icon01"),
        UIImage(named: "icon02"),
        UIImage(named: "icon03"),
        UIImage(named: "icon04"),
        UIImage(named: "icon05"),
        UIImage(named: "icon06")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰의 헤더 역할
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .brown
        
        // 테이블 뷰의 헤더 뷰로 지정
        self.tableView.tableHeaderView = headerView
        
        // 이름 레이블 속성 정의
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.textColor = .white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.emailLabel.backgroundColor = .clear
        
        headerView.addSubview(self.nameLabel)
        
        // 이메일 레이블 속성 정의
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        self.emailLabel.textColor = .white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = .clear
        
        headerView.addSubview(self.emailLabel)
        
        // 기본 이미지 구현
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        // 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2)
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        view.addSubview(self.profileImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 큐에서 테이블 셀을 꺼내온다. 없으면 새로 생성한다.
        let id = "menucell" // 테이블 셀 객체
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지 대입
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // 선택된 행이 새글 작성 메뉴일 때
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            
            // revealViewController를 통해 frontViewController를 참조, 화면전환을 위해 UINavigationController로 캐스팅
            let target = self.revealViewController().frontViewController as! UINavigationController
            
            // MemoForm 으로 push 화면 이동
            target.pushViewController(uv!, animated: true)
            
            // 사이드 바 닫기
            self.revealViewController().revealToggle(self)
            
        } else if indexPath.row == 5 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            
            // 모달 - 풀 스크린
            uv?.modalPresentationStyle = .fullScreen
            
            // present 메서드로 화면 전환
            self.present(uv!, animated: true) {
                // 화면이 전환 되면 사이드 바 닫기
                self.revealViewController().revealToggle(self)
            }
            
        }
    }

}
