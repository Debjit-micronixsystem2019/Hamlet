/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import StoreKit

class ProductCell: UITableViewCell {
    @IBOutlet var lblProductTitle: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var buyButtonHandler: ((_ product: SKProduct) -> Void)?
    
    var product: SKProduct? {
        didSet {
            guard let product = product else { return }
            if product.localizedTitle == "Annual" {
//                let attributsBold = [NSAttributedString.Key.font : UIFont(name: "Montserrat-Bold", size: 18)]
//                let attributsNormal = [NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 16)]
//                let attributedString = NSMutableAttributedString(string: "Annual ", attributes:attributsNormal as [NSAttributedString.Key : Any])
//                let boldStringPart = NSMutableAttributedString(string: "best Value ", attributes:attributsBold as [NSAttributedString.Key : Any])
//                let attributedStringLast = NSMutableAttributedString(string: "less than 50% off", attributes:attributsNormal as [NSAttributedString.Key : Any])
//                attributedString.append(boldStringPart)
//                attributedString.append(attributedStringLast)
                
                lblProductTitle.attributedText =
                NSMutableAttributedString()
                    .normal16("Annual ")
                    .bold18("BEST VALUE ")
                    .normal16("less than 50% off\n")
                    .normal14("- You will be able to use all the features for 12 months from the date of purchase")
            } else {
                lblProductTitle.attributedText =                 NSMutableAttributedString()
                    .normal16(product.localizedTitle)
                    .normal14("\n- You will be able to use all the features for \(product.localizedTitle) from the date of purchase")
            }
            
            //      if RazeFaceProducts.store.isProductPurchased(product.productIdentifier) {
            //        accessoryType = .checkmark
            //        accessoryView = nil
            //        lblProductPrice?.text = ""
            //      } else
            if IAPHelper.canMakePayments() {
                ProductCell.priceFormatter.locale = product.priceLocale
                lblProductPrice?.text = ProductCell.priceFormatter.string(from: product.price)
                
                accessoryType = .none
                accessoryView = self.newBuyButton()
            } else {
                lblProductPrice?.text = "Not available"
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblProductTitle?.text = ""
        lblProductPrice?.text = ""
        accessoryView = nil
    }
    
    func newBuyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Buy", for: .normal)
        button.addTarget(self, action: #selector(ProductCell.buyButtonTapped(_:)), for: .touchUpInside)
        button.sizeToFit()
        
        return button
    }
    
    @objc func buyButtonTapped(_ sender: AnyObject) {
        buyButtonHandler?(product!)
    }
}
