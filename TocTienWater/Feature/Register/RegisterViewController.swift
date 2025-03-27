//
//  RegisterViewController.swift
//  TocTienWater
//
//  Created by Tuan Bui on 14/3/25.
//

import UIKit
import Combine
import PhotosUI

class RegisterViewController: BaseViewController {
    
    weak var coordinator: RegisterCoordinator?
    let viewModel: RegisterViewModelProtocol
    var imageSelected: UIImage?
    private var type: UploadImageType?
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeader(title: "Đăng kí lắp đặt",
                        leftButtonIcon: "chevron.left",
                        leftButtonAction: { [weak self] in
            self?.coordinator?.back()
        })
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellWithNib(RegisterTextFieldCell.self)
        tableView.registerCellWithNib(RadioButtonCell.self)
        tableView.registerCellWithNib(RegisterImageCell.self)
        tableView.registerCellWithNib(RegisterBottomCell.self)
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        setBinding()
        viewModel.fetchData()
    }
    
    private func setBinding() {
        viewModel.dataSourcePublisher
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func openImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        UIApplication.shared.keyWindow?.rootViewController?.present(picker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func showCustomAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = UIColor(hexString: "#2B6469")
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        }

        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
            self?.openImagePicker()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)

        if let cameraImage = UIImage(systemName: "camera")?.withRenderingMode(.alwaysTemplate) {
            cameraAction.setValue(cameraImage, forKey: "image")
        }
        
        if let galleryImage = UIImage(systemName: "photo.on.rectangle")?.withRenderingMode(.alwaysTemplate) {
            galleryAction.setValue(galleryImage, forKey: "image")
        }
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension RegisterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getDataCell().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = viewModel.getDataCell()[indexPath.row]
        switch dataCell.type {
        case .textField(let inputType):
            let cell = tableView.dequeueCell(RegisterTextFieldCell.self, for: indexPath)
            cell.configCell(with: inputType, registerData: viewModel.getRegistrationData())
            cell.delegate = self
            return cell
        case .customerType(let label, let options):
            let cell = tableView.dequeueCell(RadioButtonCell.self, for: indexPath)
            cell.configCell(label: label, options: options, selected: viewModel.getRegistrationData().customerType)
            cell.delegate = self
            return cell
        case .waterUsagePurpose(let label, let options):
            let cell = tableView.dequeueCell(RadioButtonCell.self, for: indexPath)
            cell.configCell(label: label, options: options, selected: viewModel.getRegistrationData().waterUsagePurpose)
            cell.delegate = self
            return cell
        case .imageUpload(let type):
            let cell = tableView.dequeueCell(RegisterImageCell.self, for: indexPath)
            cell.configCell(type: type, images: viewModel.getImages(type: type))
            cell.delegate = self
            return cell
        case .bottom:
            let cell = tableView.dequeueCell(RegisterBottomCell.self, for: indexPath)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension RegisterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataCell = viewModel.getDataCell()[indexPath.row]
        switch dataCell.type {
        case .imageUpload(let type):
            if let numberOfImages = viewModel.getImages(type: type)?.count, numberOfImages > 0 {
                let numberOfRows = (numberOfImages + 3) / 3
                let height = CGFloat(numberOfRows) * 133 + type.title.height(withConstrainedWidth: tableView.frame.width - 16,
                                                                             font: .systemFont(ofSize: 14))
                return height
            } else {
                return type.title.height(withConstrainedWidth: tableView.frame.width - 16,
                                         font: .systemFont(ofSize: 14)) + 58
            }
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - RadioButtonCellDelegate
extension RegisterViewController: RadioButtonCellDelegate {
    func selelectButton(options: CustomerType) {
        self.view.endEditing(true)
        viewModel.setCustomerType(customerType: options)
    }
    
    func selelectButton(options: WaterUsagePurpose) {
        self.view.endEditing(true)
        viewModel.setWaterUsagePurpose(waterUsagePurpose: options)
    }
}


// MARK: - RegisterTextFieldCellDelegate
extension RegisterViewController: RegisterTextFieldCellDelegate {
    func endEditing(text: String, inputType: InputType?) {
        switch inputType {
        case .fullName:
            viewModel.setFullName(fullName: text)
        case .installationAddress:
            viewModel.setInstallationAddress(installationAddress: text)
        case .phoneNumber:
            viewModel.setPhoneNumber(phoneNumber: text)
        case .email:
            viewModel.setEmail(email: text)
        case .representativeName:
            viewModel.setRepresentativeName(representativeName: text)
        case .contactAddress:
            viewModel.setContactAddress(contactAddress: text)
        default:
            break
        }
    }
}

// MARK: - RegisterBottomCellDelegate
extension RegisterViewController: RegisterBottomCellDelegate {
    func register() {
        self.view.endEditing(true)
        // TODO: - call api register
    }
    
    func backRoot() {
        self.view.endEditing(true)
        coordinator?.back()
    }
}

// MARK: - RegisterImageCellDelegate
extension RegisterViewController: RegisterImageCellDelegate {
    func chooseImage(type: UploadImageType?) {
        self.type = type
        showCustomAlert()
    }
}

// MARK: - PHPickerViewControllerDelegate
extension RegisterViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            guard let image = image as? UIImage else { return }
            DispatchQueue.main.async {
                self?.handleSelectedImage(image)
            }
        }
    }
    
    private func handleSelectedImage(_ image: UIImage) {
        if let type = type {
            self.viewModel.insertImageSelected(type: type, image: image)
            tableView.reloadData()
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[.editedImage] as? UIImage {
            handleSelectedImage(selectedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            handleSelectedImage(originalImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
