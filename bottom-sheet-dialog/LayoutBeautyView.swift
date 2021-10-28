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
        view.backgroundColor = hexStringToUIColor(hex: "#F5F5F5")
        return view
    }()
    
    private lazy var buttonDefault = UIButton(frame: .zero)
    
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
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.buttonDefault = WhiteButton(frame: .zero).build(
            context: self,
            title: "Clique aqui",
            selector: #selector(cliqueAqui)
        )
    }
    
    @objc private func cliqueAqui() {
        print("LOG >> clique aqui sucesso")
    }
    
    func setupConstraints() {
        view.addSubview(containerView)
        
        self.titleLabel.text = titleDialog
        containerView.addSubview(titleLabel)
        
        self.descriptionLabel.text = descriptionDialog
        containerView.addSubview(descriptionLabel)
        
        containerView.addSubview(buttonDefault)
        
        view.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(0)
            make.height.greaterThanOrEqualTo(0)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel).offset(30)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.height.greaterThanOrEqualTo(0)
        }
        
        buttonDefault.snp.makeConstraints { make in
            make.topMargin.equalTo(descriptionLabel.snp.bottomMargin).offset(30)
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(50)
        }
    }
}
