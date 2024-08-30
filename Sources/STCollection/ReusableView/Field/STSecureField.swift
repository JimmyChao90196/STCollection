import SwiftUI

public enum STFieldStyle {
    case normal
    case block
    case oneLineMode
}

public struct STSecureField: View {
    
    @Binding var password: String
    var style: STFieldStyle = .normal
    let placeholder: String
    
    @State var isShowingPassword: Bool = false
    @FocusState.Binding var isFieldFocus: STTextFieldType?
    let fieldType: STTextFieldType
    
    public init(
        password: Binding<String>,
        style: STFieldStyle = .normal,
        placeholder: String,
        isShowingPassword: Bool = false,
        isFieldFocus: FocusState<STTextFieldType?>.Binding,
        fieldType: STTextFieldType) {
        self._password = password
        self.style = style
        self.placeholder = placeholder
        self.isShowingPassword = isShowingPassword
        self._isFieldFocus = isFieldFocus
        self.fieldType = fieldType
    }
    
    public var body: some View {
        HStack {
            
            if fieldType.icon != nil {
                fieldType.icon
            }
            
            Group {
                ZStack {
                    TextField("", text: $password)
                        .placeholder(placeholder, when: password.isEmpty)
                        .focused($isFieldFocus, equals: fieldType)
                        .opacity(isShowingPassword ? 1: 0)
                    
                    SecureField("", text: $password)
                        .placeholder(placeholder, when: password.isEmpty)
                        .focused($isFieldFocus, equals: fieldType)
                        .opacity(isShowingPassword ? 0: 1)
                }
            }
            .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
            .fontWeight(.bold)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .multilineTextAlignment(.leading)
            .padding(5)
            .frame(maxWidth: .infinity)
            
            Button {
                isShowingPassword.toggle()
                isFieldFocus = fieldType
            } label: {
                Image(systemName: isShowingPassword ? "eye" : "eye.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 27, height: 27)
            }
            .frame(maxWidth: 30, alignment: .trailing)
            .foregroundStyle(.ST_1B0851)
            .padding(.trailing)
        }
        .if(style == .normal) { view in
            view
                .padding(.horizontal, 5)
                .innerShadow(.white, 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1)
                }
        } else: { view in
            view
                .padding(.horizontal, 10)
                .padding(.vertical)
                .bubbleStyle(.ST_CBD8E8, 20)
        }
        .padding(.horizontal, 1)
        .onDisappear {
            isFieldFocus = nil
        }
    }
}
