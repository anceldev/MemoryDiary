//
//  MemoryView.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 30/10/24.
//

import SwiftUI

struct MemoryView: View {
    let memory: Memory
    
    init(_ memory: Memory) {
        self.memory = memory
    }
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading){
                    Image(.preview)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text(memory.title)
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .bold))
                        HStack {
                            ForEach(Array(memory.tags.enumerated()), id: \.offset) { _, tag in
                                Text("#\(tag)")
                                    .italic()
                                    .foregroundStyle(.gray1)
                                    .font(.system(size: 14, weight: .light))
                            }
                        }
                        Text(memory.content)
                            .foregroundStyle(.white)
                            .padding(.top, 16)
                        Spacer()
                    }
                    .padding(.top, 16)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 70)
            .padding(.horizontal, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.bg)
        .background(ignoresSafeAreaEdges: .top)
        .ignoresSafeArea()
    }
}

