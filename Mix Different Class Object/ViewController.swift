//
//  ViewController.swift
//  Mix Different Class Object
//
//  Created by Nitin Bhatia on 27/04/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var lblDontMiss: UILabel!
    var dontMissData : [AnyObject] = []
    
  //  var delegate : cellSelected!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readJSONFile()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
   
    fileprivate lazy var dateFormatter2: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
    }()
    
   
    
    //Mark:- CollectionView delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dontMissData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryDetailCollectionViewCell
    
    if ( dontMissData[indexPath.row].isKind(of: EventModel.self) ) {
    let data = dontMissData[indexPath.row] as! EventModel
    
    cell.lblTitle.text = data.title
    cell.lblDesc.text = self.dateFormatter2.string(from: self.dateFormatter2.date(from:  data.date)!)
    
    if let url = URL(string:data.image)  {
    cell.imgBanner.image = #imageLiteral(resourceName: "flam")
  //  cell.imgBanner.contentMode = .scaleAspectFill
        cell.imgBanner.contentMode = .scaleAspectFit

    } else {
    cell.imgBanner.image = #imageLiteral(resourceName: "flam")
    cell.imgBanner.contentMode = .scaleAspectFit
    }
    } else if ( dontMissData[indexPath.row].isKind(of: Articles.self ) ) {
    let data = dontMissData[indexPath.row] as! Articles
    cell.lblTitle.text = data.title
    let dt = data.publishUp.components(separatedBy: " ")
    cell.lblDesc.text = self.dateFormatter2.string(from: self.dateFormatter2.date(from:  dt[0])!)
    
    
    if let url = URL(string:data.image)  {
    cell.imgBanner.image = #imageLiteral(resourceName: "flam")
   // cell.imgBanner.contentMode = .scaleAspectFill
        cell.imgBanner.contentMode = .scaleAspectFit

        
    } else {
    cell.imgBanner.image = #imageLiteral(resourceName: "flam")
    cell.imgBanner.contentMode = .scaleAspectFit
    }
    }
    
    cell.lblShare.isHidden = true
    cell.lblLike.isHidden = true
    cell.lblComment.isHidden = true
    
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collView.frame.width / 2, height: self.collView.frame.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(0, 8, 2, 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
   // delegate.indexSeclectedWithSection!(section:indexPath.section,row: indexPath.row)
        
        if let data = dontMissData[indexPath.row] as? EventModel  {
//            let sb = UIStoryboard(name: "Event", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "eventDetail") as! EventTabBar
//            vc.event = data
//            self.navigationController?.pushViewController(vc, animated: true)
            print(data)
        } else {
           let article = self.dontMissData[indexPath.row] as! Articles
           
            
            print(article)
        }
    
    }
    
    func readJSONFile(){
        
        
        if let path = Bundle.main.path(forResource: "new", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let jsonResult: NSDictionary =  try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    print(jsonResult)
                  //  let data = jsonResult["data"] as! NSDictionary
                    
                    if( jsonResult["success"] as! Bool ){
                        let results = jsonResult["data"] as! [String:AnyObject]
                        let events = results["Events"] as! NSArray
                        let netArticle = results["Articles"] as! NSArray
                        
                        for event in events {
                            let tempData = event as! [String:String]
                            let desc = tempData["description"]?.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
                            var image = tempData["eventimage"]!
                            
                            if ( image != "") {
                                image = ""
                            }
                            let temp = EventModel(id: Int(tempData["id"]!)!, title: tempData["title"]!, date: tempData["startdate"]!, details: desc!, image: image,shareLink:tempData["shareUrl"]!)
                            // eventData.append(temp)
                            self.dontMissData.append(temp)
                            
                        }
                        
                        if (netArticle.count > 0){
                            for art in 0...netArticle.count - 1{
                                let data = netArticle[art] as! [String:AnyObject]
                                let temp = ReturnArticleObject.articleObject(data: data)
                                //articlesTemp.append(temp)
                                self.dontMissData.append(temp)
                                
                            }
                        }
                    
                    
                    self.collView.reloadData()
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }

}

