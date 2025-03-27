//
//  BaseViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    init() {
        let nibName = String(describing: type(of: self))
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            super.init(nibName: nibName, bundle: nil)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let customHeaderView: WaterHeader = {
        let header = WaterHeader()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.isHidden = true
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    private func setupBaseUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(customHeaderView)
        setupHeaderConstraints()
    }
    
    // Thiết lập constraints cho header
    private func setupHeaderConstraints() {
        NSLayoutConstraint.activate([
            customHeaderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            customHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customHeaderView.heightAnchor.constraint(equalToConstant: (Utils.shared.safeAreaInsets?.top ?? 0) + 54)
        ])
    }
    
    // Các phương thức public để subclass tùy chỉnh
    func showHeader(_ show: Bool) {
        customHeaderView.isHidden = !show
    }
    
    func configureHeader(
        title: String? = nil,
        leftButtonIcon: String? = nil,
        rightButtonIcon: UIImage? = nil,
        showLeftButton: Bool = true,
        showRightButton: Bool = false,
        leftButtonAction: (() -> Void)? = nil,
        rightButtonAction: (() -> Void)? = nil
    ) {
        customHeaderView.setTitle(title ?? "")
        customHeaderView.setLeftButtonIcon(UIImage(systemName: leftButtonIcon ?? ""))
        customHeaderView.setRightButtonIcon(rightButtonIcon)
        customHeaderView.setLeftButtonHidden(!showLeftButton)
        customHeaderView.setRightButtonHidden(!showRightButton)
        
        customHeaderView.leftButtonAction = leftButtonAction
        customHeaderView.rightButtonAction = rightButtonAction
        
        if (leftButtonAction != nil && leftButtonIcon == nil) {
            customHeaderView.setLeftButtonIcon(UIImage(systemName: "chevron.left"))
        }
        showHeader(true)
    }
    
}
