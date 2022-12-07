//
//  ImagePicker.swift
//  RealEstateClone
//
//  Created by Reenad gh on 13/01/1444 AH.
//
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}



struct ImagesPicker: UIViewControllerRepresentable {
    @Binding var pickerResult: [UIImage] // pass images back to the SwiftUI view
    @Binding var isPresented: Bool // close the modal view

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 8
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagesPicker

        init(_ parent: ImagesPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
          // unpack the selected items
          for image in results {
            if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
              image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                if let error = error {
                  print("Can't load image \(error.localizedDescription)")
                } else if let image = newImage as? UIImage {
                  // Add new image and pass it back to the main view
                    DispatchQueue.main.async {
                        self?.parent.pickerResult.append(image)
                    }
                }
              }
            } else {
              print("Can't load asset")
            }
          }
          parent.isPresented = false
        }
  

    }
}
