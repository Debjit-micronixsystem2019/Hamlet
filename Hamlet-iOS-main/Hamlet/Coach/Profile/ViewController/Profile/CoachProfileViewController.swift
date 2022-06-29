//
//  CoachProfileViewController.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift
import Alamofire
import SDWebImage

class CoachProfileViewController: UIViewController {

    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var profileBGView: UIView!{
        didSet{
            profileBGView.layer.shadowRadius = 6
            profileBGView.layer.shadowOffset = .zero
            profileBGView.layer.shadowOpacity = 0.4
            profileBGView.layer.cornerRadius = 24
        }
    }
    @IBOutlet weak var profileImage: UIImageView! {
        didSet{
            profileImage.layer.borderWidth = 1.0
            profileImage.layer.masksToBounds = false
            profileImage.layer.borderColor = UIColor.black.cgColor
            /*profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true*/
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var expertiselabel: UILabel!

    @IBAction func cameraButtonAction(_ sender : UIButton){
        showCameraAlert()
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        showSignOutAlert()
    }

    @IBAction func profileEditButtonAction(_ sender : UIButton){
        let mainStoryBoard = UIStoryboard(name: "CoachProfile", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CoachProfileEditViewController") as! CoachProfileEditViewController
        vc.user_name = profileVM.profileResponse?.name ?? ""
        vc.user_dob = profileVM.profileResponse?.dob ?? ""
        vc.user_gender = profileVM.profileResponse?.gender ?? ""
        vc.user_id = profileVM.profileResponse?.id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSignOutAlert() {
        HTAlert.showAlertWithOptions(title: "Sign Out", message: "Are you sure you want to sign out?", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                UserDefaults.standard.removeObject(forKey: "selectExpertisesSubmit")
                UserDefaults.standard.removeObject(forKey: "selectProblemSubmit")
                self.signOut()
            }
        }
    }
    

    private func signOut() {
        let mainStoryBoard = UIStoryboard(name: "LogIn", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    var profileVM = CoachProfileViewModel()
    private lazy var imagePicker = ImagePicker()
    var uploadimage = String()
    let refreshControl = UIRefreshControl()
    
    var arrray = ["A","b","c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.rating = 0
        imagePicker.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getProfileData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        getProfileData()
        refreshControl.endRefreshing()
    }
    
    // MARK:- Show Camera alert
    func showCameraAlert() {
        
        let alert = UIAlertController(title: "", message: "Choose your option", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            //            self.getImage(fromSourceType: .camera)
            self.imagePicker.cameraAsscessRequest()
            
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            //            self.getImage(fromSourceType: .photoLibrary)
            self.imagePicker.photoGalleryAsscessRequest()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Get Profile Data
    private func getProfileData() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        profileVM.requestProfileData{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
                if let details = self?.profileVM.profileResponse {
                    print("Data: ",details)
                    self?.userName.text = details.email ?? ""
                    let rating = Double(details.averageRating ?? "0")
                    self?.ratingView.rating = rating ?? 0
                    self?.profileImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    self?.profileImage.sd_setImage(with: URL(string:details.profilePicture ?? ""), placeholderImage: UIImage(systemName: "person.circle.fill"))
                    UserDefaults.standard.setValue(details.profilePicture, forKey: Defaults.userProfileUrl)
                    
                    
                 //   print("SelExpertise",details.experties)
                    if let expertise = details.experties{
                        let expertiseName = expertise.map {($0.name) ?? nil}.compactMap({$0}).joined(separator: ", ")
                        self?.expertiselabel.text = expertiseName
                    }
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
        
    //MARK:Image Upload
    func callsendImageAPI(image: UIImage, imageKey: String, URlName: String, completion: @escaping (Bool) -> Void){
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            guard let imgData = image.jpegData(compressionQuality: 0.1) else { return }
            multipartFormData.append(imgData, withName: imageKey, fileName: imageKey, mimeType: "")
        },to: URlName, usingThreshold: UInt64.init(),
          method: .post,
          headers: Authentication().headers).response{ response in
            if let error = response.error {
                print(error.errorDescription ?? "")
                completion(false)
            } else if let data = response.data {
               // print("data",response.value as Any)
               // print("url",URlName)
                
                do {
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: (self.view)!, animated: true)
                    }
                    let jsonData = try JSONDecoder().decode(ImageUploadResponse.self, from: data )
                    print("json : ",jsonData)
                    if jsonData.status == 200 {
                        self.view.makeToast("Your Profile image uploaded." , duration: 3.0, position: .bottom)
                        self.getProfileData()
                    }else{
                        self.view.makeToast("Internal Server Error." , duration: 3.0, position: .bottom)
                    }
                } catch let error as NSError {
                    print("ErrorReason=",error.localizedFailureReason as Any)
                }
                completion(true)
            }
        }
    }
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    @objc func photoButtonTapped(_ sender: UIButton) {
        imagePicker.photoGalleryAsscessRequest() }
    @objc func cameraButtonTapped(_ sender: UIButton) {
        imagePicker.cameraAsscessRequest()
    }
}
extension CoachProfileViewController: ImagePickerDelegate {
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        profileImage.image = image
        
        callsendImageAPI(image: image, imageKey: "profile_picture", URlName: profileImageUploadURL, completion: { [weak self] (success) in
            if success {
                self?.imagePicker.dismiss()
            }
        })
        
        if let data:Data = image.pngData() {
        }
        imagePicker.dismiss()
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss()
        
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }
    
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                DispatchQueue.main.async {
                    self.presentImagePicker(sourceType: .camera)
                }
            } else {
                self.view.makeToast("Device has no camera." , duration: 3.0, position: .bottom)
            }
        }
    }
}





