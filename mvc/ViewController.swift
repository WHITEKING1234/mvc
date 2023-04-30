//
//  ViewController.swift
//  mvc
//
//  Created by Mac on 27/4/23.
//

import UIKit

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var titleNameChangec: String?
    var descriptionChange: String?
    
    let detail: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    let titleName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let imagePhone: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let buttonHeart: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        view.backgroundColor = .white
    }
    func foto(image: String){
        imagePhone.image = UIImage(named: image)
    }
    private func initUI(){
        
        view.addSubview(detail)
        view.addSubview(titleName)
        titleName.text = titleNameChangec
        view.addSubview(imagePhone)
        view.addSubview(buttonHeart)
        view.addSubview(descriptionLabel)
        descriptionLabel.text = descriptionChange
        
        detail.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(170)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(31)
        }
        titleName.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.top.equalTo(detail.snp.bottom).offset(30)
            make.height.equalTo(98)
        }
        buttonHeart.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(52)
            make.height.width.equalTo(45)
        }
        imagePhone.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(67)
            make.top.equalTo(titleName.snp.bottom).offset(35)
            make.height.equalTo(229)
        }
        descriptionLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(imagePhone.snp.bottom).offset(30)
            make.bottom.equalToSuperview().offset(10)
        }
    }
}

