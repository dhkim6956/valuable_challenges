//
//  AuthTableViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/09/02.
//

import UIKit
import Toast_Swift

class AuthTableViewController: UITableViewController {
    
    
    
    @IBOutlet var layers: [UIView]!
    
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var remainTryLabel: UILabel!
    @IBOutlet weak var authMethodLabel: UILabel!
    
    @IBOutlet weak var cameraIcon: UIImageView!
    
    
    @IBOutlet weak var authReview: UITextView!
    @IBOutlet weak var reviewLayout: UIView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var authImage: UIImageView!
    
    
    var authChallenge: UserChallenge!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        for layer in layers {
            layer.layer.cornerRadius = 10
            layer.layer.shadowOpacity = 0.3
            layer.layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.layer.shadowRadius = 3
            layer.layer.masksToBounds = false
        }
        authReview.layer.cornerRadius = 10
        authReview.layer.borderWidth = 1
        authReview.layer.borderColor = UIColor.lightGray.cgColor
        
        sortLabel.text = authChallenge.getSort()
        titleLabel.text = authChallenge.title
        progressLabel.text = "\(Int(authChallenge.getDoneAuthenticationCount()))/\(Int(authChallenge.getTotalAuthenticationCount()))회"
        remainTryLabel.text = "남은 기회: \(authChallenge.remainTry)"
        authMethodLabel.text = authChallenge.authenticationMethod
        
        progress.setProgress(authChallenge.getDoneAuthenticationCount()/authChallenge.getTotalAuthenticationCount(), animated: true)
        
        authReview.delegate = self
        authReview.textColor = UIColor.lightGray
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cameraButtonClicked(sender:)))
        
        cameraIcon.addGestureRecognizer(tapRecognizer)
        cameraIcon.isUserInteractionEnabled = true
    }
    
    
    @objc func cameraButtonClicked(sender: UIImage) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            self.view.makeToast("장치에 사용가능한 카메라가 없습니다.", duration: 3, position: .top, title: "촬영 불가", image: UIImage(named: "addnewphoto"), style: .init(), completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    @IBAction func authButtonTapped(_ sender: Any) {
        
        print("authButtonTapped")
        
        if let image = authImage.image {
            guard let imageName = imageLabel.text else { return }
            if authReview.text != "" {
                let authChallengeIndex = authChallenge.originalIndex
                
                for (arrayIndex,userChallenge) in UserChallenges.enumerated() {
                    if userChallenge.originalIndex == authChallengeIndex {
                        
                        let dueDateIndex = UserChallenges[arrayIndex].checkTodaysDueDateIndex()
                        
                        UserChallenges[arrayIndex].dueDates[dueDateIndex].authenticationReview = authReview.text
                        UserChallenges[arrayIndex].dueDates[dueDateIndex].authenticationImage = imageName
                        UserChallenges[arrayIndex].dueDates[dueDateIndex].dueDateStatus = .authenticated
                        
                        let indexFolder = userChallenge.originalIndex
                        
                        
                        
                        let url = documentsPath.appendingPathComponent("\(indexFolder)/\(imageName).jpg")
                        if let data = image.jpegData(compressionQuality: 1.0) {
                            do { try data.write(to: url)
                            } catch {
                                print("Unable to Write Image Data to Disk")
                            }
                        }
                        print("save successful")
                        
                        
                        userData.points += 1
                        manageUserData.saveUserData()
                        
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            } else {
                print("일지를 작성해주세요")
            }
        } else {
            print("등록된 이미지가 없습니다")
        }
    }
}

extension AuthTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            authImage.image = image
        }
        let imageStringFormatter = authChallenge.customDateFormat(yyyyMMdd: "yyyy-MM-dd h:mm:ss a")
        
        
        imageLabel.text = imageStringFormatter.string(from: Date())
        //피커 닫기
        dismiss(animated: true, completion: nil)
    }
    
}


extension AuthTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                    textView.text = nil
                    textView.textColor = UIColor.label
                }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "일지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
}
