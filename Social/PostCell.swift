//
//  PostCell.swift
//  Social
//
//  Created by Mike Verpuchinskiy on 11/5/16.
//  Copyright © 2016 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
                    if error != nil {
                        print("Unable to download image from Firebase storage")
                    } else {
                        print("Image downloaded from Firebase storage")
                        if let imageData = data {
                            if let image = UIImage(data: imageData) {
                                self.postImg.image = image
                                FeedVC.imageCache.setObject(image, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                })
            }
        }
    }



