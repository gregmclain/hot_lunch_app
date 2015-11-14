prawn_document() do |pdf|
  pdf.text "Student: #{@student.first_name} #{@student.last_name}"
  pdf.text "Month: #{Date::MONTHNAMES[@month]}"
  pdf.text "Total: $#{@total}"
end