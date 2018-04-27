//
//  Articles.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 2/14/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation

class Articles{
    var id : String
    var title : String
    var fullText : String
    var introText : String
    var like : Int
    var comment : Int
    var share : String
    var image : String
    var fullImage : String
    var category : [String:String]
    var createdBy : [String:String]
    var type : String //A= audio,I=image,V=video,N=null,L=live video
    var tags : [String:AnyObject]
    var fullDataText : String
    var shareLink : String
    var publishUp : String
    var publishDown : String
    var isUserLiked : Bool
    
    init(id : String, title : String, fullText : String, introText : String, like : Int, comment : Int, share : String, category : [String:String], image : String, type: String, createdBy: [String:String],tags:[String:AnyObject],fullDataText:String, fullImage: String, shareLink: String,publishUp : String,publishDown:String,isUserLiked:Bool ){
        self.id = id
        self.title = title
        self.fullText = fullText
        self.introText = introText
        self.like = like
        self.comment = comment
        self.share = share
        self.category = category
        self.image = image
        self.type = type
        self.createdBy = createdBy
        self.tags=tags
        self.fullDataText = fullDataText
        self.fullImage = fullImage
        self.shareLink = shareLink
        self.publishUp = publishUp
        self.publishDown = publishDown
        self.isUserLiked = isUserLiked
    }
}

class FeaturedArticles : Articles{
    var article : Articles!
    
    init(article:Articles){
        
        super.init(id: article.id, title: article.title, fullText: article.fullText,introText: article.introText, like: article.like, comment: article.comment, share: article.share, category: article.category, image: article.image,type:article.type,createdBy: article.createdBy,tags: article.tags,fullDataText: article.fullDataText,fullImage: article.fullImage,shareLink: article.shareLink,publishUp: article.publishUp,publishDown: article.publishDown,isUserLiked: article.isUserLiked)
    }
}

struct subCate{
    var id : String!
    var title : String!
    
    init(id:String, title:String){
        self.id = id
        self.title = title
    }
}

class ArticleCategory{
    var id : String
    var title : String
    var parentId : String
    var level : String
    init(id:String,title:String,parentId:String,level:String){
        self.id = id
        self.title = title
        self.parentId = parentId
        self.level = level
    }
}


class ReturnArticleObject{
    class func articleObject(data:[String:AnyObject]) -> Articles{
        let cat = data["catid"] as! [String:String]
        var like = 0
        if let lk = Int(data["totalLikes"] as! String){
            like = lk
        } else {
            like = 0
        }
        let share = "0"
        var comment = 0
        if let com = Int(data["commentCount"] as! String) {
            comment = com
        } else {
            comment = 0
        }
        let id = data["id"] as! String
        let imageData = data["images"] as! [String:String]
        let title = data["title"] as! String
        let introText = data["introtext"] as! String
        let fullText = data["fulltext"] as! String
        let articleType = imageData["articleType"]
        let createdBy = data["created_by"] as! [String:String]
        var tags : [String:AnyObject] =  [:]
        var fullDataText = ""
        let fullImage = imageData["image_fulltext"]
        let shareLink = data["articleUrl"]
        let publishUp = data["publish_up"] as! String
        let publishDown = data["publish_down"] as! String
        let isUserLiked = data["userLike"] as! Bool
        
        if let tag = data["tags"] as? [String:AnyObject]{
            tags = tag
        } else {
            tags = [:]
        }
        var image = ""
        
        switch articleType{
        case "A"?:
            image = imageData["image_intro"]! //"audio_backbround"
            fullDataText = imageData["audio_fulltext"]!
        case "I"?:
            image = imageData["image_intro"]!
            fullDataText = imageData["image_fulltext"]!
        case "V"?:
            image = imageData["image_intro"]! //"video_poster"
            fullDataText = imageData["video_fulltext"]!
        case "N"?:
            image = imageData["image_intro"]!
            fullDataText = ""
        case "L"?:
            image = imageData["image_intro"]!
            fullDataText = ""
        default:
            image = ""
        }
        
        return Articles.init(id: id, title: title, fullText: fullText,introText: introText, like: like, comment: comment, share: share, category: cat, image: image, type: articleType!, createdBy: createdBy, tags:tags, fullDataText: fullDataText, fullImage: fullImage!,shareLink: shareLink as! String, publishUp: publishUp, publishDown: publishDown,isUserLiked: isUserLiked)
        
    }
}

class CommentCollection {
    var img : String!
    var name : String!
    var dateTime : String!
    var comment :String!
    
    init (img:String,name:String,dateTime:String,comment:String){
        self.img = img
        self.name = name
        self.comment = comment
        self.dateTime = dateTime
    }
}

