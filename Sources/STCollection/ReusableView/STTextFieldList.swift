
import SwiftUI

public enum InputFieldType: Hashable {
    case text(binding: Binding<String>, type: STTextFieldType)
    case date(binding: Binding<Date>, type: STTextFieldType, restriction: DateRestriction)
    case secure(binding: Binding<String>, type: STTextFieldType)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .text(_, let type):
            hasher.combine(type)
        case .date(_, let type, _):
            hasher.combine(type)
        case .secure(_, let type):
            hasher.combine(type)
        }
    }
    
    public static func == (lhs: InputFieldType, rhs: InputFieldType) -> Bool {
        switch (lhs, rhs) {
        case (.text(_, let lhsType), .text(_, let rhsType)):
            return lhsType == rhsType
        case (.date(_, let lhsType, _), .date(_, let rhsType, _)):
            return lhsType == rhsType
        case (.secure(_, let lhsType), .secure(_, let rhsType)):
            return lhsType == rhsType
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
    
    public
    init(isFocusedOn: FocusState<STTextFieldType?>.Binding,
         textFields: [InputFieldType],
         foregroundColor: Color = .ST_595757,
         style: STFieldStyle = .normal,
         spacing: CGFloat = 10,
         titleSpacing: CGFloat = 5,
         titleColor: Color = .ST_1B0851) {
            _isFocusedOn = isFocusedOn
            self.textFields = textFields
            self.foregroundColor = foregroundColor
            self.style = style
            self.spacing = spacing
            self.titleSpacing = titleSpacing
            self.titleColor = titleColor
        }
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(textFields.enumerated()), id: \.element) { index, element in
                VStack(alignment: .leading, spacing: titleSpacing) {
                    switch element {
                        
                    case .secure(let binding, let textFieldType):
                        Text(textFieldType.title).titleConfig(textColor: titleColor)
                        STSecureField(
                            password: binding,
                            style: style,
                            placeholder: textFieldType.placeholder,
                            isFieldFocus: $isFocusedOn,
                            fieldType: textFieldType)
                        .fieldSetting(keyboardType: .asciiCapable)
                        .onSubmit { submitAction(index: index) }
                        .onTapGesture {}
                        
                    case .text(let binding, let textFieldType):
                        Text(textFieldType.title).titleConfig(textColor: titleColor)
                        
                        STTextFeild(
                            inputData: binding,
                            placeholder: textFieldType.placeholder,
                            foregroundColor: foregroundColor, style: style)
                        .fieldSetting(keyboardType: textFieldType.keyboardType)
                        .focused($isFocusedOn, equals: textFieldType)
                        .padding(.bottom, 8)
                        .onTapGesture {}
                        .onSubmit {
                            submitAction(index: index)
                        }
                        
                    case .date(let binding, let textFieldType, let restriction):
                        Text(textFieldType.title).titleConfig(textColor: titleColor)
                        
                        STDateField(
                            placeholder: textFieldType.placeholder,
                            selectedDate: binding,
                            foregroundColor: foregroundColor,
                            style: style,
                            dateRestriction: restriction)
                        .onTapGesture {}
                        .padding(.bottom, 8)
                    }
                }
            }
        }
    }
    
    // MARK: Helper function -
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
