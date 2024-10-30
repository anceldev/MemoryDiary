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
//    @State var newDate: Date
    @State var newSelectedDate: Date
    
//    @Binding var selectedDate: Date
    @Binding var selectedDate: Date?
    @Binding var button: ToolButtons?
    
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    @Environment(\.dismiss) var dismiss
    
//    init(title: String? = nil, pickedDate: Binding<Date>) {
    init(title: String? = nil, selectedDate: Binding<Date?>, button: Binding<ToolButtons?>) {
        self._currentDate = State(initialValue: .now)
        self._currentMonth = State(initialValue: 0)
//        self._newDate = State(initialValue: .now)
        self._newSelectedDate = State(initialValue: .now)
        self._selectedDate = selectedDate
        self._button = button
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20, content: {
                Button(action: {
                    withAnimation { currentMonth -= 1 }
                }, label: {
                    Circle()
                        .frame(width: 16)
                        .overlay {
                            Image(systemName: "chevron.left")
                                .font(.caption2)
                                .foregroundStyle(.bg)
                        }
                })
                Spacer(minLength: 0)
                HStack(alignment: .center, spacing: 10, content: {
                    Text(extraDate()[0])
                    Text(extraDate()[1])
                })
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                Spacer(minLength: 0)
                Button(action: {
                    withAnimation { currentMonth += 1 }
                }, label: {
                    Circle()
                        .frame(width: 16)
                        .overlay {
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundStyle(.bg)
                        }
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
            HStack(spacing: 30) {
                Button(action: {
//                    withAnimation(.spring) { selectedDate = currentDate }
                    withAnimation(.spring) {
                        newSelectedDate = currentDate
                        selectedDate = newSelectedDate
                    }
                    self.button = nil
                    dismiss()
                }, label: { Text("Save") })
                
                Button(action: {
                    withAnimation(.spring) {
                        currentDate = .now
//                        selectedDate = currentDate
                        selectedDate = nil
                    }
                }, label: { Text("Clear") })
            }
            .foregroundStyle(.gray1)
        }
        .padding(16)
        .onChange(of: currentMonth) { oldValue, newValue in
            currentDate = getCurrentMonth()
        }
        .background(.toolbar)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    @ViewBuilder
    private func CardDateView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if isSameDay(date1: currentDate, date2: value.date) {
                        Text("\(value.day)")
                        .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                } else if isSameDay(date1: newSelectedDate, date2: value.date) {
                    Text("\(value.day)")
                        .font(.system(size: 12))
                        .foregroundStyle(isSameDay(date1: value.date, date2: newSelectedDate) ? .white : .red)
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
            return calendar.date(bySettingHour: 12, minute: 0, second: 0, of: calendar.date(byAdding: .day, value: day - 1, to: startDate)!)!
        }
    }
}


#Preview(traits: .sizeThatFitsLayout, body: {
    @Previewable @State var selectedDate: Date? = .now
    VStack {
        CustomDatePicker(selectedDate: $selectedDate, button: .constant(nil))
        Text(selectedDate!, style: .date)
    }
})

