
import SwiftUI

public enum InputFieldType: Hashable {
    case text(binding: Binding<String>, type: STTextFieldType)
    case date(binding: Binding<Date>, type: STTextFieldType, restriction: DateRestriction)
    case secure(binding: Binding<String>, type: STTextFieldType)
    
    public var fieldType: STTextFieldType {
        switch self {
        case .text(_, let type):
            return type
        case .date(_, let type, _):
            return type
        case .secure(_, let type):
            return type
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .text(_, let type):
            hasher.combine(type.title)
        case .date(_, let type, _):
            hasher.combine(type.title)
        case .secure(_, let type):
            hasher.combine(type.title)
        }
    }
    
    public static func == (lhs: InputFieldType, rhs: InputFieldType) -> Bool {
        switch (lhs, rhs) {
        case (.text(_, let lhsType), .text(_, let rhsType)):
            return lhsType.title == rhsType.title
        case (.date(_, let lhsType, _), .date(_, let rhsType, _)):
            return lhsType.title == rhsType.title
        case (.secure(_, let lhsType), .secure(_, let rhsType)):
            return lhsType.title == rhsType.title
        default:
            return false
        }
    }
}

public struct STTextFieldList: View {
    
    @FocusState.Binding public var isFocusedOn: STTextFieldType?
    var textFields: [InputFieldType]
    var foregroundColor: Color = .ST_595757
    var style: STFieldStyle = .normal
    var spacing: CGFloat = 10
    var titleSpacing: CGFloat = 5
    var titleColor: Color = .ST_1B0851
    var isShowIcon: Bool = true
    
    public init(isFocusedOn: FocusState<STTextFieldType?>.Binding,
                textFields: [InputFieldType],
                foregroundColor: Color = .ST_595757,
                isShowIcon: Bool = true,
                style: STFieldStyle = .normal,
                spacing: CGFloat = 10,
                titleSpacing: CGFloat = 5,
                titleColor: Color = .ST_1B0851) {
        _isFocusedOn = isFocusedOn
        self.textFields = textFields
        self.foregroundColor = foregroundColor
        self.isShowIcon = isShowIcon
        self.style = style
        self.spacing = spacing
        self.titleSpacing = titleSpacing
        self.titleColor = titleColor
    }
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(textFields.enumerated()), id: \.offset) { index, element in
                VStack(alignment: .leading, spacing: titleSpacing) {
                    switch element {
                    case .secure(let binding, let textFieldType):

                        fieldTitleMaker(textFieldType)
                        
                        STSecureField(
                            password: binding,
                            style: style,
                            placeholder: textFieldType.placeholder,
                            isShowIcon: self.isShowIcon,
                            isFieldFocus: $isFocusedOn,
                            fieldType: textFieldType)
                        .fieldSetting(keyboardType: textFieldType.keyboardType)
                        .id(textFieldType.title)
                        .onSubmit { submitAction(index: index) }
                    
                    case .text(let binding, let textFieldType):

                        fieldTitleMaker(textFieldType)
                        
                        STTextFeild(
                            inputData: binding,
                            placeholder: textFieldType.placeholder,
                            isShowIcon: self.isShowIcon,
                            foregroundColor: foregroundColor,
                            style: style,
                            fieldType: textFieldType)
                        .fieldSetting(keyboardType: textFieldType.keyboardType)
                        .id(textFieldType.title)
                        .focused($isFocusedOn, equals: textFieldType)
                        .padding(.bottom, 8)
                        .onSubmit { submitAction(index: index) }
                    
                    case .date(let binding, let textFieldType, let restriction):

                        fieldTitleMaker(textFieldType)
                        
                        STDateField(
                            placeholder: textFieldType.placeholder,
                            selectedDate: binding,
                            foregroundColor: foregroundColor,
                            style: style,
                            dateRestriction: restriction)
                        .padding(.bottom, 8)
                        .id(textFieldType.title)
                    }
                }
            }
        }
    }
    
    // MARK: Helper function -
    func fieldTitleMaker(_ input: STTextFieldType) -> some View {
        
        Text(input.title).titleConfig(textColor: titleColor)
    
    }
    
    // Switch focus to the next text field based on the current index
    func submitAction(index: Int) {
        let nextIndex = index + 1
        if nextIndex < textFields.count {
            switch textFields[nextIndex] {
            case .text(_, let nextType):
                isFocusedOn = nextType
            case .date(_, let nextType, _):
                isFocusedOn = nextType
            case .secure(_, let nextType):
                isFocusedOn = nextType
            }
        } else {
            isFocusedOn = nil
        }
    }
}
