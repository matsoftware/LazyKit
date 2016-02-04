//
//  ElementOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: - Element options protocol

public protocol ElementOptions {
	
	var viewBaseOptions: ViewBaseOptions? { get set }
	func getStyleIdentifiers(block: (styleId: String?, styleClass: String?) -> Void)
	func getStyleIdentifier(block: (identifier: String) -> Void)
}

extension ElementOptions {
	
	public func getStyleIdentifiers(block: (styleId: String?, styleClass: String?) -> Void) {
		
		switch self {
			
		case let elementOptions as LabelOptions:			block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as ButtonOptions:			block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as TextFieldOptions:		block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as TextViewOptions:			block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as ImageOptions:			block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as TableViewOptions:		block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as CollectionViewOptions:	block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
		case let elementOptions as ViewOptions:				block(styleId: elementOptions.baseOptions.styleId, styleClass: elementOptions.baseOptions.styleClass); break
			
		default: break
		}
	}
	
	public func getStyleIdentifier(block: (identifier: String) -> Void) {
		
		var identifier: String?
		
		switch self {
			
		case let elementOptions as LabelOptions:			identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as ButtonOptions:			identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as TextFieldOptions:		identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as TextViewOptions:			identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as ImageOptions:			identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as TableViewOptions:		identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as CollectionViewOptions:	identifier = elementOptions.baseOptions.identifier; break
		case let elementOptions as ViewOptions:				identifier = elementOptions.baseOptions.identifier; break
			
		default: break
		}
		
		if identifier != nil { block(identifier: identifier!) }
	}
}

//MARK: - Base options

public struct BaseOptions<T> {
	
	public typealias ElementType = T
	
	var identifier: String?
	var classType: ElementType.Type = ElementType.self
	var styleClass: String?
	var styleId: String?
	
	public init(identifier: String? = nil, classType: ElementType.Type = ElementType.self, styleClass: String? = nil, styleId: String? = nil) {
		
		self.identifier = identifier
		self.classType = classType
		self.styleClass = styleClass
		self.styleId = styleId
	}
}

//MARK: - View options

public struct ViewOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UIView>
	public var viewBaseOptions: ViewBaseOptions?
	
	public init(identifier: String? = nil, classType: UIView.Type = UIView.self, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
	}
	
	public init(identifier: String? = nil, classType: UIView.Type = UIView.self, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
	}
}

//MARK: - Label options

public struct LabelOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UILabel>
	public var viewBaseOptions: ViewBaseOptions?
	public var textOptions: TextBaseOptions?
	
	public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptions = textOptions
	}
	
	public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, text: String? = nil, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		self.textOptions = TextBaseOptions(text: text)
	}
}

//MARK: - Button options

public struct ButtonOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UIButton>
	public var viewBaseOptions: ViewBaseOptions?
	public var textOptionsForType: [LazyControlState: TextBaseOptions]?
	public var imageOptionsForType: [LazyControlState: ImageBaseOptions]?
	
	public var type: UIButtonType
	
	public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .Custom, viewBaseOptions: ViewBaseOptions? = nil, textOptionsForType: [LazyControlState: TextBaseOptions]? = nil, imageOptionsForType: [LazyControlState: ImageBaseOptions]? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptionsForType = textOptionsForType
		self.imageOptionsForType = imageOptionsForType
		self.type = type
	}
	
	public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .Custom, texts: [LazyControlState: String]? = nil, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		
		if let texts = texts {
			
			var textOptionsForType = [LazyControlState: TextBaseOptions]()
			
			for (state, text) in texts {
				
				textOptionsForType[state] = TextBaseOptions(text: text)
			}
			
			self.textOptionsForType = textOptionsForType
		}
		
		self.type = type
	}
}

//MARK: - Image options

public struct ImageOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UIImageView>
	public var viewBaseOptions: ViewBaseOptions?
	public var imageBaseOptions: ImageBaseOptions?
	
	public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, viewBaseOptions: ViewBaseOptions? = nil, imageBaseOptions: ImageBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.imageBaseOptions = imageBaseOptions
	}
	
	public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
	}
}

//MARK: - TextField options

public struct TextFieldOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UITextField>
	public var viewBaseOptions: ViewBaseOptions?
	public var textOptions: TextBaseOptions?
	public var placeholderOptions: TextBaseOptions?
	public var textInputOptions: TextInputBaseOptions?
	public var borderStyle: UITextBorderStyle?
	
	public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, placeholderOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptions = textOptions
		self.borderStyle = borderStyle
		self.placeholderOptions = placeholderOptions
		self.textInputOptions = textInputOptions
	}
	
	public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, text: String? = nil, placeholderText: String? = nil, styleClass: String? = nil, styleId: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		self.borderStyle = borderStyle
		self.textOptions = TextBaseOptions(text: text)
		self.placeholderOptions = TextBaseOptions(text: placeholderText)
		self.textInputOptions = textInputOptions
	}
}

//MARK: - TextView options

public struct TextViewOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UITextView>
	public var viewBaseOptions: ViewBaseOptions?
	public var textOptions: TextBaseOptions?
	public var textInputOptions: TextInputBaseOptions?
	
	public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptions = textOptions
		self.textInputOptions = textInputOptions
	}
	
	public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, text: String? = nil, styleClass: String? = nil, styleId: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		self.textOptions = TextBaseOptions(text: text)
		self.textInputOptions = textInputOptions
	}
}

//MARK: - TableView options

public struct TableViewOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UITableView>
	public var viewBaseOptions: ViewBaseOptions?
	public var style: UITableViewStyle = .Plain
	
	public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .Plain, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.style = style
	}
	
	public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .Plain, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		self.style = style
	}
}

//MARK: - TableView options

public struct CollectionViewOptions: ElementOptions {
	
	public var baseOptions: BaseOptions<UICollectionView>
	public var viewBaseOptions: ViewBaseOptions?
	public var collectionViewLayoutType = UICollectionViewLayout.self
	
	public init(identifier: String? = nil, classType: UICollectionView.Type = UICollectionView.self, collectionViewLayoutType: UICollectionViewLayout.Type = UICollectionViewLayout.self, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.collectionViewLayoutType = collectionViewLayoutType
	}
	
	public init(identifier: String? = nil, classType: UICollectionView.Type = UICollectionView.self, collectionViewLayoutType: UICollectionViewLayout.Type = UICollectionViewLayout.self, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		self.collectionViewLayoutType = collectionViewLayoutType
	}
}
