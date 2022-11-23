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
class Tab3ViewController : UIViewController, WriteDiaryViewDelegate{
    func didselectRegister(diary: Diary) {
            self.diaryList.append(diary)
            self.diaryTableView.reloadData()
    }
    private var diaryList : [Diary] = []{
        didSet{
//            savediaryList()
        }
    }

     var noticeButton = UIButton().then {
         $0.setTitle("Diary", for: .normal)
         $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
         $0.setTitleColor(.red, for: .normal)
         $0.setTitleColor(.gray, for: .highlighted)
     }

    var diaryTableView : UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(Tab3Cell.self, forCellReuseIdentifier: Tab3Cell.identifier)
        tableview.separatorStyle = .none

        return tableview
    }()
    lazy var WriteBtn : UIImageView = {
        let uiimageview = UIImageView(frame: CGRect(x: self.view.frame.width-100, y: self.view.frame.height-100, width: 60, height: 60))
        uiimageview.image = UIImage(named: "Pencil")
        uiimageview.layer.cornerRadius = 30
//        uiimageview.layer.shadowColor = UIColor.blue.cgColor
        uiimageview.tintColor = .green
        uiimageview.backgroundColor = .white
        uiimageview.contentMode = .scaleAspectFit
        uiimageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusdiary)))
        uiimageview.isUserInteractionEnabled = true
        return uiimageview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noticeButton)
        noticeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
        }
        setDiarytableview()
//        loadData()
        view.backgroundColor = .white
        view.addSubview(WriteBtn)
//        WriteBtn.snp.makeConstraints{
//            $0.bottom.equalToSuperview().inset(20)
//            $0.right.equalToSuperview().inset(20)
//        }
    }

//    private func savediaryList(){
//        let data = self.diaryList.map{
//            ["diaryimg": $0.diaryimg,
//             "uuidString" : $0.uuidString,
//             "date" : $0.date,
//             "content" : $0.content]
//        }
//        let users = UserDefaults.standard
//        users.set(data, forKey:  "DiaryList")
//    }
//    private func loadData(){
//        guard let user = UserDefaults.standard.object(forKey: "DiaryList") as? [[String: Any]] else {return}
//        self.diaryList = user.compactMap{
//            guard let diaryimg = $0["diaryimg"] as? UIImage else  {return nil}
//            guard let uuidString = $0["uuidString"] as? String else {return nil}
//            guard let date = $0["date"] as? String else {return nil}
//            guard let content = $0["content"] as? String else {return nil}
//            return Diary(diaryimg: diaryimg, date: date, content: content, uuidString: uuidString)
//        }
//    }
    @objc func plusdiary(){
        let writeviewController = WriteDiaryViewController()
        writeviewController.diarydelgate = self
        writeviewController.modalPresentationStyle = .fullScreen
        present(writeviewController, animated: true)
    }
    private func setDiarytableview(){
        view.addSubview(diaryTableView)
        diaryTableView.delegate = self
        diaryTableView.estimatedRowHeight = 100
        diaryTableView.rowHeight = UITableView.automaticDimension
        diaryTableView.dataSource = self
        diaryTableView.backgroundColor = .gray
        diaryTableView.snp.makeConstraints{
            $0.top.equalTo(noticeButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(changediary(_ :)), name: NSNotification.Name("editDiary"), object: nil)
    }
    @objc func deletebtnclick(){
        let actionsheet = UIAlertController(title: "제거", message: "카드를 삭제하시겠습니까?", preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        actionsheet.addAction(UIAlertAction(title: "삭제", style: .default))
        present(actionsheet, animated: true)
    }
    @objc func changediary(_ notification : Notification){
        guard let diary = notification.object as? Diary else {return}
        guard let index = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString }) else {return}
        self.diaryList[index] = diary
        self.diaryList = self.diaryList.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
        self.diaryTableView.reloadData()
        
    }


}

extension Tab3ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = diaryTableView.dequeueReusableCell(withIdentifier: Tab3Cell.identifier, for: indexPath) as? Tab3Cell else  {return UITableViewCell()}
        let diary = self.diaryList[indexPath.row]
        cell.contentslabel.text = diary.content
        cell.Writedatelabel.text = diary.date
        cell.imgview.image = diary.diaryimg
        cell.backgroundColor = .gray
        cell.deletebtn.addTarget(self, action: #selector(deletebtnclick), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextvc = WriteDiaryViewController()
        let diary = self.diaryList[indexPath.row]
        nextvc.content = diary.content
        nextvc.date = diary.date
        nextvc.photoimage = diary.diaryimg
        nextvc.diarymode = .edit
        nextvc.uuidstring = diary.uuidString
        nextvc.modalPresentationStyle = .fullScreen
        present(nextvc, animated: true)
        
    }
}
