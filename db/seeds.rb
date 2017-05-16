# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Country.destroy_all

countries = %w(
              Argentina
              Australia
              Austria
              Bahamas
              Belarus
              Belgium
              Bolivia
              Botswana
              Brazil
              Cambodia
              Cameroon
              Canada
              Chad
              Chile
              China
              Colombia
              Croatia
              Cuba
              Curacao
              Cyprus
              Czechia
              Denmark
              Dominica
              Ecuador
              Egypt
              Eritrea
              Estonia
              Ethiopia
              Fiji
              Finland
              France
              Germany
              Greece
              Haiti
              Honduras
              Hungary
              Iceland
              India
              Indonesia
              Iran
              Iraq
              Ireland
              Israel
              Italy
              Jamaica
              Japan
              Jordan
              S.Korea
              Mexico
              Micronesia
              Moldova
              Monaco
              Mongolia
              Montenegro
              Morocco
              Mozambique
              Nepal
              Netherlands
              Norway
              Pakistan
              Palau
              Panama
              Paraguay
              Peru
              Philippines
              Poland
              Portugal
              Russia
              Singapore
              Sweden
              Switzerland
              Thailand
              Togo
              Tonga
              Tunisia
              Turkey
              UK
              username
              Vanuatu
              Venezuela
              Vietnam
              Zambia
              Zimbabwe
              )

countries.each do |name|
  Country.create( name: name )
end
