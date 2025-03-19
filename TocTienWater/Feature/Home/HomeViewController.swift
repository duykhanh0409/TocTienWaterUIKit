//
//  HomeViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/8/25.
//

import UIKit
import Combine

class HomeViewController: BaseViewController {
    // Mark: Variable
    weak var coordinator: HomeCoordinator?
    let viewModel: HomeViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    // Mark: Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.sectionInset = .init(top: 10, left: 8, bottom: 10, right: 8)
        }
        setBinding()
        viewModel.fetchData()
    }
    
    
    private func setupUI() {
        // TODO: need move string to constant
        configureHeader(title: "Xin chào",
                        leftButtonIcon: "list.dash",
                        leftButtonAction: { [weak self] in
            guard let self = self else {
                return
            }
            self.coordinator?.showSlideMenu(from: self)
        })
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCellWithNib(InfoCollectionViewCell.self)
        collectionView.registerCell(CategoryCollectionViewCell.self)
        collectionView.register(HomeHeaderSectionView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HomeHeaderSectionView")
    }
    
    private func setBinding() {
        viewModel.dataSourcePublisher
            .sink { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}

// Mark: CollectionView data source
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSectionData().count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = viewModel.getSectionData()
        if section < data.count {
            return data[section].items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let anyData = viewModel.getSectionData()[indexPath.section].items[indexPath.row]
            let cell = collectionView.dequeueCell(InfoCollectionViewCell.self, for: indexPath)
            if let data = anyData as? HomeInfoData {
                cell.configCell(with: data)
            }
            return cell
        case 1:
            let anyData = viewModel.getSectionData()[indexPath.section].items[indexPath.row]
            let cell = collectionView.dequeueCell(CategoryCollectionViewCell.self, for: indexPath)
            if let data = anyData as? HomeCategory {
                cell.configCell(with: data)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 24) // Chiều cao tùy chỉnh
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HomeHeaderSectionView",
            for: indexPath) as? HomeHeaderSectionView {
            var title: String = ""
            switch indexPath.section {
            case 1:
                title = "CÁC DỊCH VỤ"
            case 2:
                title = "TRẠNG THÁI HỒ SƠ"
            default:
                break
            
            }
            if title != "" {
                headerView.configHeader(with: title,
                                        font: .systemFont(ofSize: 14, weight: .semibold),
                                        textColor: .black)
            }
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

// Mark: CollectionView delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case HomeSectionType.category.rawValue:
            if let category = viewModel.getSectionData()[indexPath.section].items[indexPath.row] as? HomeCategory {
                switch category {
                case .bills:
                    let vc = LoginViewController()
                    navigationController?.pushViewController(vc, animated: true)
                default:
                    break
                }
            }
        default:
            break
        }
    }
}

// Mark: CollectionView flow layout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width - 20
        var height: CGFloat = 50
        switch indexPath.section {
        case 1:
            width = (collectionView.frame.width - 20 - (10 * 2)) / 3
            height = 1.2 * width
        default:
            break
        }
        return CGSize(width: width, height: height)
    }
}
