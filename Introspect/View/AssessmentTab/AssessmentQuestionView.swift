//
//  AssessmentQuestionView.swift
//  Introspect
//
//  Created by Kody Deda on 4/6/21.
//

import SwiftUI
import ComposableArchitecture

struct AssessmentQuestionView: View {
    let store: Store<Assessment.State, Assessment.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Progressbar(percentage: viewStore.percentCompleted, action: { viewStore.send(.showSheetView) })
                    
                    // Question
                    Text(viewStore.currentQuestion.content)
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                        //.frame(height: geo.size.height * 0.25)
                        .frame(height: geo.size.height * 0.25, alignment: .topLeading)
                        
                    
                    //Debug Info
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                        Text(viewStore.currentQuestion.tendsToward.rawValue)
                            .font(.title)
                            .bold()
                            .padding(.vertical)
                            .foregroundColor(.green)

                        Text(viewStore.currentQuestion.tendsToward.opposite.rawValue)
                            .font(.title)
                            .bold()
                            .padding(.vertical)
                            .foregroundColor(.orange)
                            Spacer()
                        }
                        Text("introversion \(viewStore.introversion.description)")
                        Text("extroversion \(viewStore.extroversion.description)")
                        Text("sensing \(viewStore.sensing.description))")
                        Text("intuition \(viewStore.intuition.description))")
                        Text("thinking \(viewStore.thinking.description))")
                        Text("feeling \(viewStore.feeling.description))")
                        Text("judging \(viewStore.judging.description))")
                        Text("percieving \(viewStore.percieving.description))")
                    }

                    //Spacer()
                    HStack {
                        Spacer()
//                        Text("Agree")
//                            .opacity((viewStore.changingQuestion && ![.stronglyAgree, .somewhatAgree, .agree].contains(viewStore.currentQuestion.response) ? 0.1 : 1))
//                            .animation(.default, value: [.stronglyAgree].contains(viewStore.currentQuestion.response))
                        
                        ForEach(Question.Response.allCases) { response in
                            Button(action: { viewStore.send(.responseButtonTapped(response)) }) {
                                Circle()
                                    .foregroundColor(response.buttonColor)
                                
                            }
                            .opacity((viewStore.changingQuestion && viewStore.currentQuestion.response != response) ? 0.25 : 1)
                            .animation(.default, value: viewStore.changingQuestion && viewStore.currentQuestion.response != response)
//                            .frame(width: 25)
                            
                        }
//                        Text("Disagree")
//                            .opacity((viewStore.changingQuestion && ![.stronglyDisagree, .somewhatDisagree, .disagree].contains(viewStore.currentQuestion.response) ? 0.1 : 1))
//                            .animation(.spring(), value: [.stronglyAgree].contains(viewStore.currentQuestion.response))
                        Spacer()
                    }
                    .frame(height: geo.size.height * 0.25)
                    
                    //                HStack {
                    //                    Button("Back") {
                    //                        viewStore.send(.backButtonTapped)
                    //                    }
                    //                    .buttonStyle(RoundedRectangleButtonStyle())
                    //                    .disabled(viewStore.progress == .firstQuestion)
                    //                    .opacity(viewStore.progress == .firstQuestion ? 0.60 : 1.0)
                    //
                    //                    Button(viewStore.progress == .lastQuestion ? "Finish" : "Next") {
                    //                        viewStore.send(.nextButtonTapped)
                    //                    }
                    //                    .buttonStyle(RoundedRectangleButtonStyle(color: .accentColor))
                    //                }
                    //                .padding(.vertical)
                    //                .disabled(viewStore.changingQuestion)
                }
                
            }
            .padding()
            .navigationBarHidden(true)
            .sheet(isPresented: viewStore.binding(get: \.showingSheetView, send: .hideSheetView)) {
                AssessmentSheetView(store: store)
            }
        }
    }
}

struct AssessmentQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AssessmentQuestionView(store: Assessment.defaultStore)
    }
}
