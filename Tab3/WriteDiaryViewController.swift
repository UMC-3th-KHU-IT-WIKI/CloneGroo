//
//  WriteDiaryViewController.swift
//  CloneGroo
//
//  Created by SunHo Lee on 2022/11/09.
//

import Foundation
import SnapKit
import PhotosUI
import UIKit
//새로만들기, 편집모드
enum DiaryMode {
    case new
    case edit
}
//new diary delegate
protocol WriteDiaryViewDelegate : AnyObject {
    func didselectRegister(diary : Diary)
}

class WriteDiaryViewController : UIViewController{
    var content : String?
    var date : String?
    var photoimage : UIImage?
    lazy var imgView : UIImageView = { //이미 있을때는 저장된 포토를 내보내고 아니면 시스템 포토.
        let img = UIImageView()
        if let photoimage = photoimage {
            img.image = photoimage
        }else{
            img.image = UIImage(systemName: "photo")}
        return img
    }()
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        var formatter = DateFormatter()
        formatter.dateFormat = "YY.MM.dd"
        if let date = date {
            label.text = date
        }
        else{
            var currentDate = formatter.string(from: Date())
            label.text = currentDate}
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy private var DiaryContents : UITextView = {
        let text = UITextView()
        if let content = content {
            text.text = content
        }
        else{
            text.text = "오늘 식물과의 하루는 즐거웠나요?"
            text.textColor = .placeholderText}
        text.delegate = self
        return text
    }()
    lazy var finishBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: self.view.bounds.width/2 - 50, y: self.view.bounds.height - self.view.bounds.height/4, width: 100, height: 100))
        btn.setTitle("완성", for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .black
        btn.setImage(.add, for: .normal)
        btn.addTarget(self, action: #selector(updateclick), for: .touchUpInside)
        return btn
    }()
    weak var diarydelgate : WriteDiaryViewDelegate?//딜리게이트 패턴 이용
    var diarymode : DiaryMode = .new
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setimgView()
        setdateLabel()
        self.view.isUserInteractionEnabled = true
        settextField()
        view.addSubview(finishBtn)
        finishBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
    override func viewWillAppear(_ animated: Bool) { //키보드나타나고 사라질때의 이벤트 설정.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisAppear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) { //메모리보호 뷰사라지면 옵저버 안쓰기에 지워줌.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //빈화면을 눌러줄때마다 키보드나 데이트 피커 사라짐.
    }
    @objc func keyboardWillshow(notification: NSNotification){
        if let keyboardFrame : NSValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue){
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardheight =  keyboardRectangle.height
            self.view.frame = CGRect(x: 0, y: -keyboardheight, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }}
    @objc func keyboardWillDisAppear(notification : NSNotification){
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    @objc func pickimg(){
        photoview()
 
    }
    private func setimgView(){
        view.addSubview(imgView)
        imgView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickimg))
        imgView.addGestureRecognizer(tapGesture)
      
        imgView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(view.snp.height).dividedBy(2.5)
        }
    }
    private func setdateLabel(){
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(imgView.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(40)
        }
        lineView.backgroundColor = UIColor(red: 155/255, green: 156/255, blue: 157/255, alpha: 1)
        view.addSubview(lineView)
        lineView.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(40)
        }
    }
    private func settextField(){
        view.addSubview(DiaryContents)
        DiaryContents.snp.makeConstraints{
            $0.top.equalTo(lineView.snp.bottom).offset(15)
            $0.left.right.equalTo(lineView)
            $0.bottom.equalToSuperview().offset(-150)
        }
    }
    @objc func updateclick(){
        guard let date = self.dateLabel.text else {return}
        guard let contents = self.DiaryContents.text else {return}
        guard let img = self.imgView.image else { return}
        switch self.diarymode {
        case .new :
            let diary = Diary(diaryimg: img, date: date, content: contents, uuidString:  UUID().uuidString)
            self.diarydelgate?.didselectRegister(diary: diary)
            dismiss(animated: true)
        case .edit:
            let diary = Diary(diaryimg: img, date: date, content: contents, uuidString: UUID().uuidString)
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"), object: diary)
 }
        print("bugtton")    }
}
extension WriteDiaryViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return}
        textView.textColor = .label
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘 식물과의 하루는 어땠나요?"
            textView.textColor = .placeholderText
        }
    }
    
}
extension WriteDiaryViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate{
    func photoview(){
        let actionsheet = UIAlertController(title: "사진", message: "어떻게 사진을 고르시겠습니까?", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        actionsheet.addAction(UIAlertAction(title: "새로운 사진찍기", style: .default, handler: {
            [weak self] _ in self?.presentCamera()
        }))
        actionsheet.addAction(UIAlertAction(title: "라이브러리에서 사진가져오기", style: .default, handler: {
            [weak self] _ in self?.presentphotopicker()
        }))
        present(actionsheet, animated: true)
    }
    private func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    private func presentphotopicker(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self){
                (image,error) in DispatchQueue.main.async {
                    self.imgView.image = image as? UIImage
                    
                }
            }
        }
        else{
            
        }
    }
    
}
