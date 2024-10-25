//
//  CustomDatePicker.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 25/10/24.
//

import SwiftUI

struct CustomDatePicker: View {
    @State var currentDate: Date
    @State var currentMonth: Int
    @State var newDate: Date
    
    
//    @Binding var pickedDate: Date?
    @Binding var pickedDate: Date
    var title: String?
    
    let days = ["S", "M", "T", "W", "T", "F", "S"]
//    var datePicked: Bool {
//        if pickedDate == nil {
//            return false
//        }
//        return true
//    }
    
    @Environment(\.dismiss) var dismiss
    
    init(title: String? = nil, pickedDate: Binding<Date>) {
        self._currentDate = State(initialValue: .now)
        self._currentMonth = State(initialValue: 0)
        self._newDate = State(initialValue: .now)
        self._pickedDate = pickedDate
        self.title = title
    }
    
    var body: some View {
        VStack {
//            ZStack {
//                if title != nil {
//                    Text(title!)
//                        .font(.system(size: 20, weight: .regular, design: .rounded))
//                        .foregroundStyle(.gray)
//                }
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        dismiss()
//                    }, label: {
//                        Image(systemName: "x")
//                    })
//                }
//            }
            HStack(spacing: 20, content: {
                Button(action: {
                    withAnimation {
                        currentMonth -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                })
                Spacer(minLength: 0)
                HStack(alignment: .center, spacing: 10, content: {
                    Text(extraDate()[0])
                    Text(extraDate()[1])
                })
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
                Spacer(minLength: 0)
                Button(action: {
                    withAnimation {
                        currentMonth += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.headline)
                })
            })
            .foregroundStyle(.gray)
            .padding(.horizontal)
            .padding(.bottom, 25)
            
            HStack(spacing: 0, content: {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 14))
                }
            })
            .padding(.bottom, 4)
            .foregroundStyle(.gray)
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 8, content: {
                ForEach(extractDate()) { value in
                    CardDateView(value: value)
                        .background(
                            Circle()
                                .fill(.orange)
                                .frame(width: value.day != -1 ? 20 : 0)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            })
            Button(action: {
//                newDate = currentDate
//                withAnimation(.spring) {
//                    pickedDate = newDate
//                    currentDate = pickedDate!
//                }
                withAnimation(.spring) {
                    pickedDate = currentDate
                }
            }, label: {
                Text("Save")
            })
//            .buttonStyle(.mainButton())
            Button(action: {
                withAnimation(.spring) {
                    currentDate = .now
                    pickedDate = currentDate
                    print("Picked date is now = nil \(String(describing: pickedDate))")
                }
            }, label: {
                Text("Clear")
            })
//            .buttonStyle(.mainButton(.cancel))
        }
        .padding(16)
        .onChange(of: currentMonth) { oldValue, newValue in
            currentDate = getCurrentMonth()
        }
        .background(.bg)
    }
    
    @ViewBuilder
    private func CardDateView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if isSameDay(date1: pickedDate, date2: value.date) {
                    Text("\(value.day)")
                        .font(.system(size: 12))
                        .foregroundStyle(.bg)
                        .frame(width: 20, height: 20)
                        .background(
                            backgroundCardView(color: .orange)
                        )
//                        .background(
//                            LinearGradient(colors: [.pink], startPoint: .bottom, endPoint: .top)
//                                .shadow(.inner(color: .pink, radius: 1, x: 0, y: -3))
//                        )
                        
                        .clipShape(Circle())
                } else if isSameDay(date1: currentDate, date2: value.date) {
                    Text("\(value.day)")
                        .font(.system(size: 12))
                        .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ? .bg.opacity(0.8) : .red)
                        
//                        .background(
//                            backgroundCardView(color: .pink)
//                        )
                } else {
                    Text("\(value.day)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ? .gray1 : .white)
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 30, alignment: .center)
    }
    
    @ViewBuilder
    private func backgroundCardView(color: Color) -> some View {
//        RoundedRectangle(cornerRadius: 8)
//            .fill(color)
//            .frame(width: 45, height: 33)
        Circle()
            .fill(.orange)
            .frame(width: 24, height: 24)
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    private func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    private func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let dateValue = DateValue(day: day, date: date)
            return dateValue
        }
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekDay - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    private struct DateValue: Identifiable {
        var id = UUID().uuidString
        var day: Int
        var date: Date
    }
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)
        return range!.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


#Preview(traits: .sizeThatFitsLayout, body: {
    @Previewable @State var pickedDate: Date = .now
    return  VStack {
        CustomDatePicker(title: "Title", pickedDate: $pickedDate)
        Text(pickedDate, style: .date)
    }
})

