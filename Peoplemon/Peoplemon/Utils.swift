//
//  Utils.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/7/16.
//  Copyright © 2016 Interapt. All rights reserved.
//
import Foundation
import AFDateHelper

// Step 9: Create file and showError/isValidEmail functions//garbage dumping ground
class Utils {

    class func createAlert(_ title: String = "Error", message: String, dismissButtonTitle: String = "Dismiss") -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil))
        return alert
    }

    class func isValidEmail(_ testStr: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9-_.]+[@]{1}[A-Za-z0-9-]+[.]*[A-Za-z0-9-]+[.]{1}[A-Za-z]+"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    class func adjustedTime(_ date: Date = Date()) -> Date {
        return date.dateByAddingSeconds(TimeZone.current.secondsFromGMT())
    }

    class func isNumber(_ string: String) -> Bool {
        let set = CharacterSet(charactersIn:"0123456789.-").inverted
        let components = string.components(separatedBy: set)
        let filtered = components.joined(separator: "")
        return string == filtered
    }

    class func formatNumber(_ amount: Double, prefix: String) -> String {
        return String(format: "\(prefix)$%.2f", abs(amount))
    }
    //converts picture to string
    class func imageToString(image: UIImage?) -> String?{

        if let image = image{
            let pictureData = UIImagePNGRepresentation(image)
            let pictureToString64 = pictureData?.base64EncodedString()
            return pictureToString64
        }else{
            return nil
        }
    }
    class func stringToImage(str: String?) -> UIImage?{

        if let str = str{

            let imageData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            if imageData == nil{
                return nil
            }
            if let image = UIImage(data: imageData as! Data){
                return image
            }
            return nil

        }else{
            return nil
        }
    }
}
