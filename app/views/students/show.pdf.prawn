prawn_document() do |pdf|
  pdf.text "Student: #{@student.first_name} #{@student.last_name}"
  pdf.text "Month: #{Date::MONTHNAMES[@month]}"
  pdf.text "Total: $#{@total}"

  pdf.move_down 20

  pdf.text "Cash, Check, and Credit Card are all accepted forms of payment."
  pdf.text "Please make checks payable to Tropical Oasis."

  pdf.move_down 15

  pdf.text "Card Number: ______-______-______-______    Expiration Date: ____/____    CVV: _____"
  pdf.move_down 5
  pdf.text "Name on the card: ______________________________"
  pdf.move_down 5
  pdf.text "Signature: ______________________________"
end