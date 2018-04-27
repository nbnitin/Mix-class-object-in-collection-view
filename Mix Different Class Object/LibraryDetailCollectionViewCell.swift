//
//  LibraryDetailCollectionViewCell.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 2/14/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit

protocol cellDelegate {
    func cellNeedToRemove(id: String)
}

class LibraryDetailCollectionViewCell: UICollectionViewCell {
    
    //Mark:- Outlets
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblCat: UILabel!
    @IBOutlet weak var lblCatDesc: UILabel!
    @IBOutlet weak var imgPlay: UIImageView!
    @IBOutlet weak var btnShare: UIButton!
    
    //Mark:- Outlets
    var delegate : cellDelegate!
    var articleId : String!
    var libId : String!
    var vc : UIViewController!
    var view : UIView!
    
    //Mark:- Btn delete code
    
    @IBAction func btnDelete(_ sender: Any) {
       // self.showLoad()
        removeCellApi()
    }
    
    //Mark:- Btn share code
    
    @IBAction func btnShare(_ sender: Any) {
        let text = self.lblShare.text
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.vc.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
    //Mark:- Api to remove cell or item
    
    func removeCellApi(){
//        let apiHandler = ApiHandler()
//        var parameter : [String:String] = [:]
//        parameter["libraryid"] = libId
//        parameter["itemid"] = articleId
//
//        apiHandler.sendPostRequest(url: apiUrl.removeArticleFromLibrary,parameters:parameter, completionHandler: {(response,error) in
//
//            if ( error != nil ) {
//                self.hideLoad()
//                print(error?.localizedDescription)
//                return
//            }
//            self.hideLoad()
//            self.delegate.cellNeedToRemove(id: self.articleId)
//        })
    }
    
}

