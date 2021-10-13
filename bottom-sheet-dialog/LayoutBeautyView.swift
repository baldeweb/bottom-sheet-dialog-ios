//
//  LayoutBeautyView.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 12/10/21.
//

import UIKit
import SnapKit

class LayoutBeautyView : UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.center = .zero
        label.sizeToFit()
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private var defaultHeight: CGFloat = 340
    private var dismissibleHeight: CGFloat = 240
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    private var currentContainerHeight: CGFloat = 340
    
    private var titleDialog: String = ""
    private var descriptionDialog: String = ""
    
    init?(titleLabel: String, description: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleDialog = titleLabel
        self.descriptionDialog = description
    }
    
    required init?(coder: NSCoder?) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
   
    func setupConstraints() {
        view.addSubview(containerView)
        
        self.titleLabel.text = titleDialog
        containerView.addSubview(titleLabel)
            
        self.descriptionLabel.text = descriptionDialog
        containerView.addSubview(descriptionLabel)
        
        view.snp.makeConstraints { make in
            make.width.equalTo(defaultHeight)
            make.height.equalTo(defaultHeight)
        }
       
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
    
        descriptionLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
    }
}
