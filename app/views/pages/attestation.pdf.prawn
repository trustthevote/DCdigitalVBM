def paragraph(pdf, txt)
  pdf.text txt, :indent_paragraphs => -12, :leading => 3
  pdf.move_down 10
end

pdf.stroke_color "888888"
pdf.font_size 10

# Header
pdf.image "public/images/print-logo.jpg", :at => [ 0, 705 ], :scale => 0.6
        
pdf.bounding_box [ 45, 700 ], :width => 200 do
  pdf.text "District of Columbia", :style => :bold, :leading => 3
  pdf.text "Board of Elections & Ethics"
end

pdf.bounding_box [ 200, 700 ], :width => 200 do
  pdf.text "Attestation of Eligibility", :style => :bold, :leading => 3
  pdf.text "To be completed by elector"
end

pdf.stroke_line [ pdf.bounds.left, 660 ], [ pdf.bounds.right, 660 ]

# Main part
pdf.font_size 11
pdf.bounding_box [ 0, 640 ], :width => 150 do
  pdf.text "I swear or affirm under penalty of perjury that:", :style => :bold
end

pdf.bounding_box [ 200, 640 ], :width => 300 do
  paragraph pdf, "1. I am a U.S. citizen, at least 18 years of age, and I am eligible to vote in the District of Columbia; and"
  paragraph pdf, "2. I am not incarcerated for a crime that is a felony in the District of Columbia, nor have I been adjudicated legally incompetent to vote; and"
  paragraph pdf, "3. I am a member of the Uniformed Services or merchant marine on active duty, or an eligible spouse or dependent of such a member; or, a U.S. citizen temporarily residing outside the U.S.; or other U.S. citizen residing outside the U.S.; and"
  paragraph pdf, "4. I am not registering, requesting a ballot, or voting in any other jurisdiction in the U.S., except the District of Columbia."
  paragraph pdf, "5. I am the individual who voted the ballot included with this form."
  paragraph pdf, "6. I am the individual identified by the information below"
end

pdf.stroke_line [ pdf.bounds.left, 350 ], [ pdf.bounds.right, 350 ]

# Voter attestation
pdf.bounding_box [ 0, 330 ], :width => 150 do
  pdf.text "Voter attestation", :style => :bold
end

pdf.bounding_box [ 200, 330 ], :width => 300 do
  pdf.text "I affirm that the information on this form is true, accurate, and complete to the best of my knowledge, and that I understand that a material misstatement of fact in completion of this document may constitute grounds for a conviction for perjury.", :leading => 3
  pdf.move_down 20
  
  pdf.font_size 20
  pdf.text @registration.name
  pdf.move_down 5
  pdf.font_size 16
  pdf.text @registration.address
end

# Signature line
pdf.font_size 12
pdf.bounding_box [ 200, 115 ], :width => 80 do
  pdf.text "Signature:", :style => :bold
end
pdf.stroke_line [ 280, 100 ], [ pdf.bounds.right, 100 ]

# Date line
pdf.bounding_box [ 200, 40 ], :width => 80 do
  pdf.text "Date:", :style => :bold
end
pdf.stroke_line [ 280, 25 ], [ pdf.bounds.right, 25 ]
