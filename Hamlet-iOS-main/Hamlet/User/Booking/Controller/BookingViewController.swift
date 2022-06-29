//
//  BookingViewController.swift
//  Hamlet
//
//  Created by Basir Alam on 10/11/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class BookingViewController: UIViewController {

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
            profileImage.layer.cornerRadius = 50.0
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var giveRatingButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var bookButton: UIButton!
    @IBAction func giveRatingButtonAction(_ sender: Any) {
        print("Rating View Controller")
        let mainStoryBoard = UIStoryboard(name: "Rating", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        vc.userID = trainerID
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func bookButtonAction(_ sender: Any) {
        if dateTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || timeTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Please select booking date and time.", controller: self, completion: nil)
        }else{
            let date = dateTextField.text ?? ""
            let time = timeTextField.text ?? ""
            let dateTime = date + time
            
            print("dateTime",dateTime)
       
            showTrainerBookConfirmationAlert(id:trainerID,TrainerName : trainerName, Date: dateTime)
        }
    }
    
    
    var trainerBookingVM = TrainerBookingViewModel()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    var selectDataTimeButton = ""
    var trainerID = Int()
    var trainerName = String()
    var avgRating = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        bookButton.layer.cornerRadius = 20
        showDatePicker()
        showTimePicker()
        userName.text = trainerName
        ratingView.rating = Double(avgRating) ?? 0
    }
    
    func showTrainerBookConfirmationAlert(id:Int,TrainerName : String,Date : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: "Do you want to book \(TrainerName)", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.trainerBookingService(id : id , Date : Date)
            }
        }
    }
    
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: datePicker.date)
        dateTextField.text = date
        self.view.endEditing(true)
    }
    
    func showTimePicker() {
        //Formate Time
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = timePicker
    }
    @objc func doneTimePicker(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timestring = formatter.string(from: timePicker.date)
        timeTextField.text = " \(timestring)"
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    // MARK: - Request Data To VM From UI
    private func trainerBookingService(id : Int , Date : String) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        trainerBookingVM.requestTrainerBookingRequest( with: id, date: Date){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.trainerBookingVM.bookingResponse{
                    print("Data: ",details)
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(details.data ?? "")", controller: self!, completion: nil)

                }

                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
}

