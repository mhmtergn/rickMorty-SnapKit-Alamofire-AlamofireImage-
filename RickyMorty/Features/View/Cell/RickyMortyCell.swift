//
//  RickyMortyCell.swift
//  RickyMorty
//
//  Created by Mehmet Ergün on 2022-09-03.
//

import UIKit
import AlamofireImage

class RickyMortyCell: UITableViewCell {
    
    static let identifier = "Cell"

    private let myImageView = UIImageView()
    private let title = UILabel()
    private let myDescription = UILabel()
    private let randomImage: String = "https://picsum.photos/200/300"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(myImageView)
        addSubview(title)
        addSubview(myDescription)
        
        title.font = .boldSystemFont(ofSize: 18)
        myDescription.font = .italicSystemFont(ofSize: 10)
        
        myImageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(contentView)
            make.leading.trailing.equalToSuperview()
            
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(myImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(myImageView)
        }
        
        myDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.leading.trailing.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        myDescription.text = model.status
        myImageView.af.setImage(withURL: (URL(string: model.image ?? randomImage) ?? URL(string: randomImage))!)
        
    }
    

}
