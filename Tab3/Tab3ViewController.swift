//
//  Tab3ViewController.swift
//  CloneGroo
//
//  Created by JOSUEYEON on 2022/10/06.
//

import Foundation
import UIKit
import SnapKit
import Then
import SwiftUI
class Tab3ViewController : UIViewController{

     var noticeButton = UIButton().then {
         $0.setTitle("Diary", for: .normal)
         $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
         $0.setTitleColor(.black, for: .normal)
         $0.setTitleColor(.gray, for: .highlighted)
     }

    var diaryTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(Tab3Cell.self, forCellReuseIdentifier: Tab3Cell.identifier)
        return tableview
    }()

    var contents1 = Diary(diaryimg: UIImage(named: "madic")!, date: Date(), content: "안녕하게요")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noticeButton)
        setDiarytableview()
        view.backgroundColor = .white
        
    }
    private func setDiarytableview(){
        view.addSubview(diaryTableView)
        diaryTableView.delegate = self
        diaryTableView.dataSource = self
        diaryTableView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview()
        }
    }


}

extension Tab3ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Tab3Cell.identifier, for: indexPath) as! Tab3Cell
        cell.photoview = contents1.diaryimg
        cell.writeDate = contents1.date
        cell.contents = contents1.content
        return cell
    }
}
