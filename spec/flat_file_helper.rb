# This file contains Flat::File definitions that can be used to test the
# various features and functions of Flat.

class PersonFile < Flat::File

  EXAMPLE_FILE = <<-EOF
1234567890123456789012345678901234567890
f_name    l_name              age pad---
Captain   Stubing             4      xxx
No        Phone               5      xxx
Has       Phone     11111111116      xxx

EOF

  add_field :f_name, :width => 10

  add_field :l_name, :width => 10, :aggressive => true

  add_field :phone, :width => 10

  add_field :age, :width => 4, :filter => proc { |v| v.to_i }, :formatter => proc { |v| v.to_f.to_s }

  pad :auto_name, :width => 3

  add_field :ignore, :width => 3, :padding => true

end
